const path = {
  main: "/vitepress/",
};

const introduction = [
  { text: "什么是 VitePress", link: `${path.main}guide/` },
  { text: "快速开始", link: `${path.main}guide/introduction/quickstart` },
  { text: "路由", link: `${path.main}guide/introduction/route` },
  { text: "部署指南", link: `${path.main}guide/introduction/deploy` },
];

const writing = [
  { text: "Markdown扩展 ", link: `${path.main}guide/writing/md` },
  { text: "表情符号", link: `${path.main}guide/writing/emoji` },
  { text: "资源处理", link: `${path.main}guide/writing/resources` },
  { text: "frontmatter", link: `${path.main}guide/writing/frontmatter` },
  { text: "markdown中使用Vue", link: `${path.main}guide/writing/using-vue` },
  { text: "国际化", link: `${path.main}guide/writing/i18n` },
];

const custom = [{ text: "概述", link: `${path.main}guide/customization/` }];

const guide = [
  { text: "介绍", collapsed: true, items: introduction },
  { text: "写作", collapsed: true, items: writing },
  { text: "定制", collapsed: true, items: custom },
];

const defaultTheme = [
  { text: "概述", link: `${path.main}conf/default-theme/overview` },
  { text: "Nav", link: `${path.main}conf/default-theme/nav` },
  { text: "侧边栏", link: `${path.main}conf/default-theme/sidebar` },
  { text: "主页", link: `${path.main}conf/default-theme/home` },
  { text: "页脚", link: `${path.main}conf/default-theme/footer` },
  { text: "布局", link: `${path.main}conf/default-theme/layout` },
  { text: "徽章", link: `${path.main}conf/default-theme/badge` },
  { text: "团队页面", link: `${path.main}conf/default-theme/team` },
];

const reference = [
  { text: "站点配置", link: `${path.main}conf/site` },
  { text: "前言配置", link: `${path.main}conf/frontmatter` },
  { text: "运行时API", link: `${path.main}conf/runtime-api` },
  { text: "命令行界面", link: `${path.main}conf/cli` },
  { text: "默认主题", collapsed: true, items: defaultTheme },
];

const sidebar = [
  { text: "概述", link: `${path.main}` },
  { text: "使用指南", collapsed: true, items: guide },
  { text: "配置参考", collapsed: true, items: reference },
];

export default sidebar;
