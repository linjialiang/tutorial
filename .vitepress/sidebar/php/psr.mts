const path = {
  main: "/php/psr/",
};

const sidebar = [
  { text: "概述", link: `${path.main}` },
  { text: "1. 基本编码标准", link: `${path.main}psr-1` },
  { text: "12. 扩展编码风格指南", link: `${path.main}psr-12` },
  { text: "PER编码风格2.0", link: `${path.main}coding-style` },
  { text: "3. 日志接口", link: `${path.main}psr-3` },
  { text: "4. 自动加载", link: `${path.main}psr-4` },
  { text: "6. 缓存接口", link: `${path.main}psr-6` },
  { text: "HTTP 消息接口", link: `${path.main}psr-7` },
  { text: "容器接口", link: `${path.main}psr-11` },
  { text: "超媒体链接", link: `${path.main}psr-13` },
  { text: "事件分发器", link: `${path.main}psr-14` },
  { text: "HTTP 处理程序", link: `${path.main}psr-15` },
];

export default sidebar;
