import clash from './clash.mts';
import js from './js.mts';
import wechat from './wechat.mts';

const path = {
  main: '/other/',
};

const sidebar = [
  { text: '概述', link: `${path.main}` },
  { text: 'clash', collapsed: true, items: clash },
  { text: 'wechat', collapsed: true, items: wechat },
  { text: 'javascript', collapsed: true, items: js },
];

export { sidebar as other };
