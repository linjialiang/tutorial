import bash from './bash';
import debian from './debian';

const sidebar = [
  { text: 'Debian', collapsed: true, items: [...debian] },
  { text: 'Bash', collapsed: true, items: [...bash] },
];

export default sidebar;
