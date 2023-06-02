import vitepress from './vitepress';
import vscode from './vscode';

const path = {
  main: '/other/',
};

const sidebar = [
  { text: '概述', link: `${path.main}` },
  { text: 'vitepress', collapsed: true, items: vitepress },
  { text: 'vscode', collapsed: true, items: vscode },
];

export default sidebar;
