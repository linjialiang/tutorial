const path = {
  main: "/environment/",
};

const sidebar = [
  { text: "概述", link: `${path.main}` },
  { text: "Nginx", link: `${path.main}nginx` },
  { text: "PostgreSQL", link: `${path.main}pgsql_compile` },
  { text: "PHP", link: `${path.main}php` },
  {
    text: "存档(不再积极维护)",
    collapsed: true,
    items: [
      { text: "PostgreSQL(apt)", link: `${path.main}archive/pgsql` },
      { text: "MySQL", link: `${path.main}archive/mysql_compile` },
      { text: "MySQL(apt)", link: `${path.main}archive/mysql` },
      { text: "Redis", link: `${path.main}archive/redis` },
      { text: "MongoDB", link: `${path.main}archive/mongodb` },
      { text: "Sqlite3", link: `${path.main}archive/sqlite3` },
    ],
  },
];

export { sidebar as environment };
