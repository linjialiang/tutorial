const path = {
  main: "/environment/",
};

const sidebar = [
  { text: "概述", link: `${path.main}` },
  { text: "Nginx", link: `${path.main}nginx` },
  { text: "Redis", link: `${path.main}redis` },
  { text: "PostgreSQL", link: `${path.main}pgsql_compile` },
  { text: "PHP", link: `${path.main}php` },
  { text: "PHP(pgsql版)", link: `${path.main}php_pgsql` },
  {
    text: "存档(不再积极维护)",
    collapsed: true,
    items: [
      { text: "PostgreSQL(apt)", link: `${path.main}archive/pgsql` },
      { text: "MySQL", link: `${path.main}archive/mysql_compile` },
      { text: "MySQL(apt)", link: `${path.main}archive/mysql` },
      { text: "MongoDB", link: `${path.main}archive/mongodb` },
      { text: "Sqlite3", link: `${path.main}archive/sqlite3` },
    ],
  },
];

export { sidebar as environment };
