import phpstorm from './phpstorm.mts';
import sublime from './sublime.mts';
import vim from './vim.mts';
import vscode from './vscode.mts';

const path = {
  main: '/editor/',
};

const sidebar = [
  { text: '概述', link: `${path.main}` },
  { text: 'sublime', collapsed: true, items: [...sublime] },
  { text: 'vscode', collapsed: true, items: [...vscode] },
  { text: 'phpstorm', collapsed: true, items: [...phpstorm] },
  { text: 'vim', collapsed: true, items: [...vim] },
];

export { sidebar as editor };
