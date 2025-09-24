import designPatterns from './design-patterns.mts';
import psr from './psr.mts';

const path = {
  main: '/php/',
};

const sidebar = [
  { text: '概述', link: `${path.main}` },
  { text: '面向对象', link: `${path.main}oop` },
  { text: 'PSR', collapsed: true, items: [...psr] },
  { text: '设计模式', collapsed: true, items: [...designPatterns] },
];

export { sidebar as php };
