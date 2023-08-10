import bash from "./bash.mjs";
import debian from "./debian.mjs";

const sidebar = [
  { text: "Debian", collapsed: true, items: [...debian] },
  { text: "Bash", collapsed: true, items: [...bash] },
];

export default sidebar;
