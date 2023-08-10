import css from "./css/main.mjs";
import debian from "./debian/main.mjs";
import docker from "./docker/main.mjs";
import environment from "./environment/main.mjs";
import es6 from "./es6/main.mjs";
import html from "./html/main.mjs";
import js from "./js/main.mjs";
import kafka from "./kafka/main.mjs";
import mongodb from "./mongodb/main.mjs";
import nginx from "./nginx/main.mjs";
import other from "./other/main.mjs";
import php from "./php/main.mjs";
import redis from "./redis/main.mjs";
import sql from "./sql/main.mjs";
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
  "/html/": html,
  "/css/": css,
  "/js/": js,
  "/es6/": es6,
  "/vue/": vue,
  "/other/": other,
};

export default sidebar;
