const path = {
  main: "/docker/",
  official: "/docker/official/",
};

const official = [
  { text: "概述", link: `${path.official}` },
  { text: "安装docker", link: `${path.official}install` },
  { text: "在 Docker 中管理数据", link: `${path.official}storage` },
  { text: "使用 卷 持久存储", link: `${path.official}volumes` },
  { text: "使用 绑定挂载 持久存储", link: `${path.official}bind_mounts` },
  { text: "使用 tmpfs 临时存储", link: `${path.official}tmpfs_mounts` },
  { text: "排查卷错误", link: `${path.official}troubleshoot` },
];

const sidebar = [
  { text: "Docker概览", link: `${path.main}` },
  { text: "安装Docker", link: `${path.main}/install` },
  { text: "官方手册", collapsed: true, items: official },
];

export default sidebar;
