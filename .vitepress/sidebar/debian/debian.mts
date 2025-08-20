import gui from './gui.mts';

const path = {
  main: '/debian/',
};

const sidebar = [
  { text: '概述', link: `${path.main}` },
  { text: '安装操作系统', link: `${path.main}install_os` },
  { text: '安装操作系统(debain13)', link: `${path.main}install_os_debian13` },
  { text: '配置操作系统', link: `${path.main}config_os` },
  { text: 'zsh', link: `${path.main}zsh` },
  { text: 'samba', link: `${path.main}samba` },
  { text: 'gui', collapsed: true, items: [...gui] },
];

export default sidebar;
