import debian from "./debian/main";
import environment from "./environment/main";
import mongodb from "./mongodb/main";
import nginx from "./nginx/main";
import php from "./php/main";
import redis from "./redis/main";
import sql from "./sql/main";

const sidebar = {
  "/environment/": environment,
  "/debian/": debian,
  "/nginx/": nginx,
  "/sql/": sql,
  "/mongodb/": mongodb,
  "/redis/": redis,
  "/php/": php,
};

export default sidebar;
