import bash from "./bash.mts";
import debian from "./debian.mts";

const sidebar = [
  { text: "Debian", collapsed: true, items: [...debian] },
  { text: "Bash", collapsed: true, items: [...bash] },
];

export { sidebar as debian };
