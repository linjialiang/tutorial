import { defineConfig } from "vitepress";
import environmentNav from "./nav/environment";
import sidebar from "./sidebar/main";

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "PHP Environment",
  description: "基于Debian的php环境搭建教程",
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: "主页", link: "/" },
      { text: "PHP环境搭建", items: environmentNav },
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
  lastUpdated: true,
});
