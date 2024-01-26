import common from "./common/main.mjs";
import mysql from "./mysql/main.mjs";
import pgsql from "./pgsql/main.mjs";
import sqlite3 from "./sqlite3/main.mjs";

const sidebar = [
  { text: "SQL", collapsed: true, items: [...common] },
  { text: "MySQL", collapsed: true, items: [...mysql] },
  { text: "Sqlite3", collapsed: true, items: [...sqlite3] },
  { text: "PostgreSQL", collapsed: true, items: [...pgsql] },
];

export { sidebar as sql };
