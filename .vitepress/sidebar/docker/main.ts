const path = {
  main: '/docker/',
};

const sidebar = [
  { text: '概述', link: `${path.main}` },
  { text: '安装docker', link: `${path.main}install` },
  { text: '在 Docker 中管理数据', link: `${path.main}storage` },
  { text: '使用 卷 持久存储', link: `${path.main}volumes` },
  { text: '使用 绑定挂载 持久存储', link: `${path.main}bind_mounts` },
  { text: '使用 tmpfs 临时存储', link: `${path.main}tmpfs_mounts` },
  { text: '排查卷错误', link: `${path.main}troubleshoot` },
];

export default sidebar;
