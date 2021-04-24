/** @type {import('@docusaurus/types').DocusaurusConfig} */
module.exports = {
  title: 'YAGPDB Custom Commands',
  tagline: 'An up-to-date collection of CCs for your server',
  url: 'https://your-docusaurus-test-site.com',
  baseUrl: '/',
  onBrokenLinks: 'throw',
  onBrokenMarkdownLinks: 'warn',
  favicon: 'img/yag.ico',
  organizationName: 'yagpdb-cc', // Usually your GitHub org/user name.
  projectName: 'yagpdb-cc', // Usually your repo name.
  themeConfig: {
    navbar: {
      title: 'YAGPDB Custom Commands',
      logo: {
        alt: 'My Site Logo',
        src: 'img/yag.ico',
      },
      items: [
        {
          type: 'doc',
          docId: 'intro',
          position: 'left',
          label: 'YAGPDB CCs',
        },
        {
          href: 'https://github.com/yagpdb-cc/yagpdb-cc/tree/feature/website',
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
              to: '/docs/intro',
            },
          ],
        },
        {
          title: 'Community',
          items: [
            {
              label: 'YAGPDB Github',
              href: 'https://stackoverflow.com/questions/tagged/docusaurus',
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
      copyright: `Copyright © ${new Date().getFullYear()} under MIT Liscense.`,
    },
  },
  presets: [
    [
      '@docusaurus/preset-classic',
      {
        docs: {
          sidebarPath: require.resolve('./sidebars.js'),
          // Please change this to your repo.
          editUrl:
            'https://github.com/facebook/docusaurus/edit/master/website/',
          routeBasePath: '/',
        },
        blog: false,
        theme: {
          customCss: require.resolve('./src/css/custom.css'),
        },
      },
    ],
  ],
};