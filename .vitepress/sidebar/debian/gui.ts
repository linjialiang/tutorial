const path = {
  main: '/debian/gui/',
};

const sidebar = [
  { text: '概述', link: `${path.main}` },
  { text: 'VMware', link: `${path.main}vmware` },
  { text: 'PhpStorm', link: `${path.main}phpstorm` },
  { text: 'VSCode', link: `${path.main}vscode` },
  { text: 'Sublime Text', link: `${path.main}sublime` },
  { text: '输入法', link: `${path.main}pinyin` },
  { text: 'Navicat', link: `${path.main}navicat` },
  { text: 'NodeJS', link: `${path.main}nodejs` },
];

export default sidebar;
