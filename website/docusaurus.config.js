/** @type {import('@docusaurus/types').DocusaurusConfig} */
module.exports = {
  title: "YAGPDB Custom Commands",
  tagline: "An up-to-date collection of CCs for your server",
  url: "https://yagpdb-cc.github.io",
  baseUrl: "/",
  onBrokenLinks: "throw",
  onBrokenMarkdownLinks: "warn",
  favicon: "img/yag.ico",
  organizationName: "yagpdb-cc",
  projectName: "yagpdb-cc.github.io",
  themeConfig: {
    colorMode: {
      defaultMode: "dark",
      respectPrefersColorScheme: true,
      switchConfig: {
        darkIcon: "🌙",
        lightIcon: "☀️",
      },
    },
    navbar: {
      title: "YAGPDB Custom Commands",
      logo: {
        alt: "YAGPDB logo",
        src: "img/yag.ico",
      },
      items: [
        {
          type: "doc",
          docId: "intro",
          position: "left",
          label: "YAGPDB CCs",
        },
        {
          href: "https://github.com/yagpdb-cc/yagpdb-cc/tree/master",
          label: "GitHub",
          position: "right",
        },
      ],
    },
    footer: {
      style: "dark",
      links: [
        {
          title: "Docs",
          items: [
            {
              label: "YAGPDB CCs",
              to: "/",
            },
          ],
        },
        {
          title: "Community",
          items: [
            {
              label: "YAGPDB Github",
              href: "https://github.com/jonas747/yagpdb",
            },
            {
              label: "Discord",
              href: "https://discord.com/invite/4udtcA5",
            },
          ],
        },
        {
          title: "More",
          items: [
            {
              label: "YAGPDB CC GitHub",
              href: "https://github.com/yagpdb-cc/yagpdb-cc",
            },
          ],
        },
      ],
      copyright: `Copyright © ${new Date().getFullYear()} under the MIT license.`,
    },
  },
  presets: [
    [
      "@docusaurus/preset-classic",
      {
        docs: {
          sidebarPath: require.resolve("./sidebars.js"),
          editUrl: "https://github.com/yagpdb-cc/yagpdb-cc/edit/master/website",
          routeBasePath: "/",
          remarkPlugins: [require("remark-code-import")],
        },
        blog: false,
        theme: {
          customCss: require.resolve("./src/css/custom.css"),
        },
      },
    ],
  ],
};
