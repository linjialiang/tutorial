import clash from "./clash.mjs";
import js from "./js.mjs";
import wechat from "./wechat.mjs";

const path = {
  main: "/other/",
};

const sidebar = [
  { text: "概述", link: `${path.main}` },
  { text: "clash", collapsed: true, items: clash },
  { text: "wechat", collapsed: true, items: wechat },
  { text: "javascript", collapsed: true, items: js },
];

export { sidebar as other };
