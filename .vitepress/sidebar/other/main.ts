import clash from './clash';
import vitepress from './vitepress';
import vscode from './vscode';
import wechat from './wechat';

const path = {
  main: '/other/',
};

const sidebar = [
  { text: '概述', link: `${path.main}` },
  { text: 'vitepress', collapsed: true, items: vitepress },
  { text: 'vscode', collapsed: true, items: vscode },
  { text: 'clash', collapsed: true, items: clash },
  { text: 'wechat', collapsed: true, items: wechat },
];

export default sidebar;
