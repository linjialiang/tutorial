import { defineConfig } from "vitepress";
import environmentNav from "./nav/environment";
import tutorialNav from "./nav/tutorial";
import sidebar from "./sidebar/main";

// https://vitepress.dev/reference/site-config
export default defineConfig({
  base: "/",
  lang: "zh-CN",
  title: "PHP Environment",
  description: "基于Debian的php环境搭建教程",
  lastUpdated: true,
  markdown: {
    lineNumbers: false,
  },
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: "主页", link: "/" },
      { text: "环境搭建", items: environmentNav },
      { text: "教程", items: tutorialNav },
    ],
    sidebar: sidebar,
    socialLinks: [{ icon: "github", link: "https://github.com/linjialiang/" }],
    editLink: {
      pattern: "https://github.com/linjialiang/php_environment/main/:path",
    },
    search: {
      provider: "local",
    },
  },
});
