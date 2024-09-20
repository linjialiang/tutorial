import clash from "./clash.mjs";
import js from "./js.mjs";
import phpstorm from "./phpstorm.mjs";
import vim from "./vim.mjs";
import vscode from "./vscode.mjs";
import wechat from "./wechat.mjs";

const path = {
  main: "/other/",
};

const sidebar = [
  { text: "概述", link: `${path.main}` },
  { text: "vscode", collapsed: true, items: vscode },
  { text: "phpstorm", collapsed: true, items: phpstorm },
  { text: "vim", collapsed: true, items: vim },
  { text: "clash", collapsed: true, items: clash },
  { text: "wechat", collapsed: true, items: wechat },
  { text: "javascript", collapsed: true, items: js },
];

export { sidebar as other };
