import vitepress from './vitepress';

const path = {
  main: '/other/',
};

const sidebar = [
  { text: '概述', link: `${path.main}` },
  { text: 'vitepress', collapsed: true, items: vitepress },
];

export default sidebar;
