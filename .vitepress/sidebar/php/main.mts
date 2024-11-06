import designPatterns from "./design-patterns.mts";
import laravel from "./laravel.mts";
import psr from "./psr.mts";

const path = {
  main: "/php/",
};

const sidebar = [
  { text: "概述", link: `${path.main}` },
  { text: "面向对象", link: `${path.main}oop` },
  { text: "设计模式", collapsed: true, items: [...designPatterns] },
  { text: "PHP标准建议", collapsed: true, items: [...psr] },
  { text: "laravel", collapsed: true, items: [...laravel] },
];

export { sidebar as php };
