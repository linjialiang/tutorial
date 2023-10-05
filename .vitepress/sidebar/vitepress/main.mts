const path = {
  main: "/vitepress/",
};

const sidebar = [
  { text: "概述", link: `${path.main}` },
  { text: "快速开始", link: `${path.main}quickstart` },
  { text: "路由", link: `${path.main}route` },
  { text: "Markdown", link: `${path.main}md` },
  { text: "配置", link: `${path.main}config` },
  { text: "默认主题", link: `${path.main}default-theme` },
  { text: "部署指南", link: `${path.main}deploy` },
  { text: "表情符号", link: `${path.main}emoji` },
];

export default sidebar;
