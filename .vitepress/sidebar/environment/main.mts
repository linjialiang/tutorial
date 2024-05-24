const path = {
  main: "/environment/",
};

const sidebar = [
  { text: "概述", link: `${path.main}` },
  { text: "Nginx", link: `${path.main}nginx` },
  { text: "PostgreSQL", link: `${path.main}pgsql_compile` },
  { text: "PHP", link: `${path.main}php` },
  {
    text: "不维护",
    collapsed: true,
    items: [
      { text: "MySQL", link: `${path.main}mysql_compile` },
      { text: "Redis", link: `${path.main}redis` },
      { text: "MongoDB", link: `${path.main}mongodb` },
      { text: "Sqlite3", link: `${path.main}sqlite3` },
    ],
  },
];

export { sidebar as environment };
