import clash from './clash.mts';
import { eslint } from './eslint.mts';
import { gitea } from './gitea.mts';
import JavaScript from './js.mts';
import { permeate } from './permeate.mts';
import { prettier } from './prettier.mts';
import wechat from './wechat.mts';

const path = {
  main: '/other/',
};

const sidebar = [
  { text: '概述', link: `${path.main}` },
  { text: 'PowerShell', link: `${path.main}powershell` },
  { text: 'RIME', link: `${path.main}rime` },
  { text: 'clash', collapsed: true, items: clash },
  { text: '微信开发', collapsed: true, items: wechat },
  { text: 'JavaScript', collapsed: true, items: JavaScript },
  { text: 'prettier', collapsed: true, items: prettier },
  { text: 'permeate', collapsed: true, items: permeate },
  { text: 'gitea', collapsed: true, items: gitea },
  { text: 'eslint', collapsed: true, items: eslint },
];

export { sidebar as other };
