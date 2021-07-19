const pagesInRootWithFixedOrder = ['introduction', 'adding-ccs'];
const pagesInCategoryWithFixedOrder = ['overview'];

function reorderSidebarItems(items, pagesWithFixedOrder) {
	const result = items.map((item) => {
		if (item.type === 'category') {
			return {
				...item,
				items: reorderSidebarItems(item.items, pagesInCategoryWithFixedOrder),
			};
		}
		return item;
	});

	// Shift all categories to the front, then shift all ordered items to the front.
	const [ordered, rest] = partition(
		partition(result, (item) => item.type === 'category').flat(1),
		(item) => item.type === 'doc' && pagesWithFixedOrder.includes(getPageName(item.id)),
	);

	// Sort the ordered items found by their position.
	ordered.sort(
		(a, b) => pagesWithFixedOrder.indexOf(getPageName(a.id)) - pagesWithFixedOrder.indexOf(getPageName(b.id)),
	);
	return [...ordered, ...rest];
}

function getPageName(id) {
	return id.split('/').pop();
}

function partition(items, predicate) {
	const pass = [];
	const fail = [];
	for (const item of items) {
		if (predicate(item)) pass.push(item);
		else fail.push(item);
	}
	return [pass, fail];
}

/** @type {import('@docusaurus/types').DocusaurusConfig} */
module.exports = {
	title: 'YAGPDB Custom Commands',
	tagline: 'An up-to-date collection of CCs for your server',
	url: 'https://yagpdb-cc.github.io',
	baseUrl: '/',
	onBrokenLinks: 'throw',
	onBrokenMarkdownLinks: 'throw',
	favicon: 'img/yag.ico',
	organizationName: 'yagpdb-cc',
	projectName: 'yagpdb-cc.github.io',
	trailingSlash: false,
	themeConfig: {
		colorMode: {
			defaultMode: 'dark',
			respectPrefersColorScheme: true,
			switchConfig: {
				darkIcon: '🌙',
				lightIcon: '☀️',
			},
		},
		prism: {
			theme: require('./src/prism-themes/github-light'),
			darkTheme: require('./src/prism-themes/ayu-dark'),
		},
		navbar: {
			title: 'YAGPDB Custom Commands',
			logo: {
				alt: 'YAGPDB logo',
				src: 'img/yag.ico',
			},
			items: [
				{
					type: 'doc',
					docId: 'introduction',
					position: 'left',
					label: 'Introduction',
				},
				{
					type: 'doc',
					docId: 'adding-ccs',
					position: 'left',
					label: 'Adding custom commands',
				},
				{
					href: 'https://github.com/yagpdb-cc/yagpdb-cc/tree/master',
					label: 'GitHub',
					position: 'right',
				},
			],
		},
		footer: {
			style: 'dark',
			links: [
				{
					title: 'Docs',
					items: [
						{
							label: 'YAGPDB CCs',
							to: '/',
						},
					],
				},
				{
					title: 'Community',
					items: [
						{
							label: 'YAGPDB Github',
							href: 'https://github.com/jonas747/yagpdb',
						},
						{
							label: 'Discord',
							href: 'https://discord.com/invite/4udtcA5',
						},
					],
				},
				{
					title: 'More',
					items: [
						{
							label: 'YAGPDB CC GitHub',
							href: 'https://github.com/yagpdb-cc/yagpdb-cc',
						},
					],
				},
			],
			copyright: `Copyright © ${new Date().getFullYear()} YAGPDB-CC contributors under the MIT license.`,
		},
	},
	presets: [
		[
			'@docusaurus/preset-classic',
			{
				docs: {
					sidebarPath: require.resolve('./sidebars.js'),
					editUrl: 'https://github.com/yagpdb-cc/yagpdb-cc/edit/master/website',
					routeBasePath: '/',
					remarkPlugins: [require('remark-code-import')],
					sidebarItemsGenerator: async function ({ defaultSidebarItemsGenerator, ...options }) {
						const sidebarItems = await defaultSidebarItemsGenerator(options);
						return reorderSidebarItems(sidebarItems, pagesInRootWithFixedOrder);
					},
				},
				blog: false,
				theme: {
					customCss: require.resolve('./src/css/index.css'),
				},
			},
		],
	],
};
