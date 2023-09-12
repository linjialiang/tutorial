import designPatterns from "./design-patterns.mjs";
import laravel from "./laravel.mjs";

const path = {
  main: "/php/",
};

const sidebar = [
  { text: "概述", link: `${path.main}` },
  { text: "设计模式", collapsed: true, items: [...designPatterns] },
  { text: "laravel", collapsed: true, items: [...laravel] },
];

export default sidebar;
