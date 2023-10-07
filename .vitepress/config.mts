// import flexSearchIndexOptions from "flexsearch";
import { defineConfig } from "vitepress";
// import { SearchPlugin } from "vitepress-plugin-search";
import environmentNav from "./nav/environment.mjs";
import otherNav from "./nav/other.mjs";
import tutorialNav from "./nav/tutorial.mjs";
import webNav from "./nav/web.mjs";
import sidebar from "./sidebar/main.mjs";

// const options = {
//   ...flexSearchIndexOptions,
//   previewLength: 100, //搜索结果预览长度
//   buttonLabel: "搜索",
//   placeholder: "情输入关键词",
// };

// https://vitepress.dev/reference/site-config
export default defineConfig({
  // vite: { plugins: [SearchPlugin(options)] },
  base: "/",
  lang: "zh-CN",
  title: "Tutorial",
  description: "程序员系列教程",
  head: [["link", { rel: "icon", href: "/favicon.ico" }]],
  lastUpdated: true,
  markdown: {
    lineNumbers: false,
    math: true,
  },
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    logo: "/logo.png",
    lastUpdatedText: "最近更新",
    externalLinkIcon: true,
    langMenuLabel: "切换语言",
    // --------- 仅移动端显示 start
    darkModeSwitchLabel: "切换主题",
    sidebarMenuLabel: "栏目",
    returnToTopLabel: "返回顶部",
    // 仅移动端显示 end ---------
    socialLinks: [
      {
        icon: "github",
        link: "https://github.com/linjialiang/tutorial.git",
      },
      {
        icon: {
          svg: '<svg t="1685882013964" class="icon" viewBox="0 0 1024 1024" version="1.1" xmlns="http://www.w3.org/2000/svg" p-id="7153" width="600" height="600"><path d="M512 1024C229.222 1024 0 794.778 0 512S229.222 0 512 0s512 229.222 512 512-229.222 512-512 512z m259.149-568.883h-290.74a25.293 25.293 0 0 0-25.292 25.293l-0.026 63.206c0 13.952 11.315 25.293 25.267 25.293h177.024c13.978 0 25.293 11.315 25.293 25.267v12.646a75.853 75.853 0 0 1-75.853 75.853h-240.23a25.293 25.293 0 0 1-25.267-25.293V417.203a75.853 75.853 0 0 1 75.827-75.853h353.946a25.293 25.293 0 0 0 25.267-25.292l0.077-63.207a25.293 25.293 0 0 0-25.268-25.293H417.152a189.62 189.62 0 0 0-189.62 189.645V771.15c0 13.977 11.316 25.293 25.294 25.293h372.94a170.65 170.65 0 0 0 170.65-170.65V480.384a25.293 25.293 0 0 0-25.293-25.267z" fill="#d81e06" p-id="7154"></path></svg>',
        },
        link: "https://gitee.com/linjialiang/tutorial.git",
      },
    ],
    editLink: {
      pattern: "https://gitee.com/linjialiang/tutorial/main/:path",
      text: "在 gitee 上编辑",
    },
    outline: "deep",
    i18nRouting: true,
    outlineTitle: "大纲",
    docFooter: {
      prev: "上一页",
      next: "下一页",
    },
    search: {
      provider: "local",
      options: {
        translations: {
          button: {
            buttonText: "搜索文档",
            buttonAriaLabel: "搜索文档",
          },
          modal: {
            noResultsText: "无法找到相关结果",
            resetButtonTitle: "清除查询条件",
            footer: {
              selectText: "选择",
              selectKeyAriaLabel: "选择",
              navigateText: "切换",
              navigateUpKeyAriaLabel: "向上切换",
              navigateDownKeyAriaLabel: "向下切换",
              closeText: "关闭",
              closeKeyAriaLabel: "关闭",
            },
          },
        },
      },
    },
    nav: [
      { text: "主页", link: "/" },
      { text: "环境搭建", items: environmentNav },
      { text: "后端", items: tutorialNav },
      { text: "前端", items: webNav },
      { text: "其他", items: otherNav },
    ],
    sidebar: sidebar,
    footer: {
      message: "程序员系列教程",
      copyright: "Copyright © 2023-present linjialiang",
    },
  },
});
