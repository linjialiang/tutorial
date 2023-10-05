import clash from "./clash.mjs";
import vscode from "./vscode.mjs";
import wechat from "./wechat.mjs";

const path = {
  main: "/other/",
};

const sidebar = [
  { text: "概述", link: `${path.main}` },
  { text: "vscode", collapsed: true, items: vscode },
  { text: "clash", collapsed: true, items: clash },
  { text: "wechat", collapsed: true, items: wechat },
];

export default sidebar;
