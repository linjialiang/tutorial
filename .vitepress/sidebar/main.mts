import debian from "./debian/main.mjs";
import docker from "./docker/main.mjs";
import environment from "./environment/main.mjs";
import kafka from "./kafka/main.mjs";
import mongodb from "./mongodb/main.mjs";
import nginx from "./nginx/main.mjs";
import other from "./other/main.mjs";
import permeate from "./permeate/main.mjs";
import php from "./php/main.mjs";
import redis from "./redis/main.mjs";
import sql from "./sql/main.mjs";
import vitepress from "./vitepress/main.mjs";
import vue from "./vue/main.mjs";

const sidebar = {
  "/environment/": environment,
  "/debian/": debian,
  "/docker/": docker,
  "/nginx/": nginx,
  "/sql/": sql,
  "/mongodb/": mongodb,
  "/redis/": redis,
  "/kafka/": kafka,
  "/php/": php,
  "/vue/": vue,
  "/vitepress/": vitepress,
  "/other/": other,
  "/permeate/": permeate,
};

export default sidebar;
