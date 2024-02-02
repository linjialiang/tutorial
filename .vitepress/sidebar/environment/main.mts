const path = {
  main: "/environment/",
};

const sidebar = [
  { text: "概述", link: `${path.main}` },
  { text: "Nginx", link: `${path.main}nginx` },
  {
    text: "SQL",
    collapsed: true,
    items: [
      { text: "PostgreSQL", link: `${path.main}pgsql_compile` },
      { text: "MySQL", link: `${path.main}mysql_compile` },
      { text: "Sqlite3", link: `${path.main}sqlite3` },
    ],
  },
  { text: "Redis", link: `${path.main}redis` },
  { text: "PHP", link: `${path.main}php` },
  { text: "MongoDB", link: `${path.main}mongodb` },
];

export { sidebar as environment };
