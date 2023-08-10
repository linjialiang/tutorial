import clash from "./clash.mjs";
import vitepress from "./vitepress.mjs";
import vscode from "./vscode.mjs";
import wechat from "./wechat.mjs";

const path = {
  main: "/other/",
};

const sidebar = [
  { text: "概述", link: `${path.main}` },
  { text: "vitepress", collapsed: true, items: vitepress },
  { text: "vscode", collapsed: true, items: vscode },
  { text: "clash", collapsed: true, items: clash },
  { text: "wechat", collapsed: true, items: wechat },
];

export default sidebar;
