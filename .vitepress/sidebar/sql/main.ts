import common from "./common/main";
import mysql from "./mysql/main";
import pgsql from "./pgsql/main";
import sqlite3 from "./sqlite3/main";

const sidebar = [
  { text: "SQL", collapsed: true, items: [...common] },
  { text: "MySQL", collapsed: true, items: [...mysql] },
  { text: "Sqlite3", collapsed: true, items: [...sqlite3] },
  { text: "PostgreSQL", collapsed: true, items: [...pgsql] },
];

export default sidebar;
