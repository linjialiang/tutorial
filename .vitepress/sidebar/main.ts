import css from './css/main';
import debian from './debian/main';
import docker from './docker/main';
import environment from './environment/main';
import es6 from './es6/main';
import html from './html/main';
import js from './js/main';
import kafka from './kafka/main';
import mongodb from './mongodb/main';
import nginx from './nginx/main';
import other from './other/main';
import php from './php/main';
import redis from './redis/main';
import sql from './sql/main';
import vue from './vue/main';

const sidebar = {
  '/environment/': environment,
  '/debian/': debian,
  '/docker/': docker,
  '/nginx/': nginx,
  '/sql/': sql,
  '/mongodb/': mongodb,
  '/redis/': redis,
  '/kafka/': kafka,
  '/php/': php,
  '/html/': html,
  '/css/': css,
  '/js/': js,
  '/es6/': es6,
  '/vue/': vue,
  '/other/': other,
};

export default sidebar;
