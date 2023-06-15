const path = {
  main: '/environment/',
  k8sMain: '/environment/k8s/',
};

const sidebar = [
  { text: '概述', link: `${path.main}` },
  { text: 'Nginx', link: `${path.main}nginx` },
  {
    text: 'SQL',
    collapsed: true,
    items: [
      { text: 'MySQL', link: `${path.main}mysql` },
      { text: 'Sqlite3', link: `${path.main}sqlite3` },
      { text: 'PostgreSQL', link: `${path.main}pgsql` },
    ],
  },
  { text: 'Redis', link: `${path.main}redis` },
  { text: 'MongoDB', link: `${path.main}mongodb` },
  { text: 'PHP', link: `${path.main}php` },
  {
    text: 'K8S系列',
    collapsed: true,
    items: [{ text: '概述', link: `${path.k8sMain}` }],
  },
];

export default sidebar;
