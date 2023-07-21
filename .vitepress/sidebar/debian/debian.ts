import gui from './gui';

const path = {
  main: '/debian/',
};

const sidebar = [
  { text: '概述', link: `${path.main}` },
  { text: '安装操作系统', link: `${path.main}install_os` },
  { text: '配置操作系统', link: `${path.main}config_os` },
  { text: 'gui', collapsed: true, items: [...gui] },
  { text: 'GUI 桌面', link: `${path.main}gui` },
  { text: 'PhpStorm', link: `${path.main}phpstorm` },
];

export default sidebar;
