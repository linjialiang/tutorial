import common from './common/main.mts';
import mysql from './mysql/main.mts';
import pgsql from './pgsql/main.mts';
import sqlite3 from './sqlite3/main.mts';

const sidebar = [
  { text: 'SQL', collapsed: true, items: [...common] },
  { text: 'MySQL', collapsed: true, items: [...mysql] },
  { text: 'Sqlite3', collapsed: true, items: [...sqlite3] },
  { text: 'PostgreSQL', collapsed: true, items: [...pgsql] },
];

export { sidebar as sql };
