const path = {
  main: "/vitepress/",
};

const introduction = [
  { text: "介绍", link: `${path.main}guide/introduction/` },
  { text: "快速开始", link: `${path.main}guide/introduction/quickstart` },
  { text: "路由", link: `${path.main}guide/introduction/route` },
  { text: "部署指南", link: `${path.main}guide/introduction/deploy` },
];

const guide = [
  {text: "介绍", collapsed: true, items: introduction },
  { text: "Markdown", link: `${path.main}md` },
  { text: "表情符号", link: `${path.main}emoji` },
];

const reference = [
  { text: "配置", link: `${path.main}config` },
  { text: "默认主题", link: `${path.main}default-theme` },
];

const sidebar = [
  { text: "概述", link: `${path.main}` },
  { text: "使用指南", collapsed: true, items: guide },
  { text: "配置参考", collapsed: true, items: reference },
];

export default sidebar;
