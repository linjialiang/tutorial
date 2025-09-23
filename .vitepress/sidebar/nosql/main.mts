import { mongodb } from './mongodb.mts';
import { redis } from './redis.mts';

const path = {
  main: '/nosql/',
};

const sidebar = [
  { text: '概述', link: `${path.main}` },
  { text: 'mongodb', collapsed: true, items: mongodb },
  { text: 'redis', collapsed: true, items: redis },
];

export { sidebar as nosql };
