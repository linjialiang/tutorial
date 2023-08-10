import laravel from "./laravel.mjs";

const path = {
  main: "/php/",
};

const sidebar = [
  { text: "概述", link: `${path.main}` },
  { text: "laravel", collapsed: true, items: [...laravel] },
];

export default sidebar;
