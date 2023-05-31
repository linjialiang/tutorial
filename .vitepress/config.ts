import { defineConfig } from "vitepress";
import environmentNav from "./nav/environment";
import tutorialNav from "./nav/tutorial";
import sidebar from "./sidebar/main";

// https://vitepress.dev/reference/site-config
export default defineConfig({
  base: "/",
  lang: "zh",
  title: "PHP Environment",
  description: "基于Debian的php环境搭建教程",
  lastUpdated: true,
  markdown: { lineNumbers: false },
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    logo: "/logo.svg",
    lastUpdatedText: "最近更新",
    socialLinks: [{ icon: "github", link: "https://github.com/linjialiang/" }],
    editLink: {
      pattern: "https://github.com/linjialiang/php-environment/main/:path",
      text: "在 github 上编辑",
    },
    search: { provider: "local" },
    nav: [
      { text: "主页", link: "/" },
      { text: "环境搭建", items: environmentNav },
      { text: "教程", items: tutorialNav },
    ],
    sidebar: sidebar,
  },
});
