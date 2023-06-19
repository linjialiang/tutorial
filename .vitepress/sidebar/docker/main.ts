const path = {
  main: '/docker/',
};

const sidebar = [
  { text: '概述', link: `${path.main}` },
  { text: '安装docker', link: `${path.main}install` },
  { text: '在 Docker 中管理数据', link: `${path.main}storage` },
  { text: '使用 Volumes 持久存储', link: `${path.main}volumes` },
];

export default sidebar;
