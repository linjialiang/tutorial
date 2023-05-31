---
# https://vitepress.dev/reference/default-theme-home-page
layout: home

hero:
    name: 'PHP Environment'
    text: 'PHP 环境搭建'
    tagline: '基于Debian发行版的PHP环境搭建教程'
    actions:
        - theme: brand
          text: '环境搭建教程'
          link: /environment/
        - theme: alt
          text: 'SQL 教程'
          link: /sql/common/
        - theme: brand
          text: '自述'
          link: /readme

features:
    - icon:
          src: /assets/svg/debian.svg
      title: Debian 教程
      details: Linux发行版
      link: /debian/index
    - icon:
          src: /assets/svg/nginx.svg
      title: Nginx 教程
      details: Web服务器
      link: /nginx/index
    - icon:
          src: /assets/svg/mysql.svg
      title: MySQL 教程
      details: 最流行的开源关系型数据库
      link: /sql/mysql/index
    - icon:
          src: /assets/svg/redis.svg
      title: Redis 教程
      details: 最流行的键值型数据库(内存型)
      link: /redis/index
    - icon:
          src: /assets/svg/mongodb.svg
      title: MongoDB 教程
      details: 最流行的文档数据库
      link: /mongodb/index
    - icon:
          dark: /assets/svg/sqlite-dark.svg
          light: /assets/svg/sqlite-light.svg
      title: Sqlite3 教程
      details: 轻量级关系型数据库
      link: /sql/sqlite3/index
    - icon:
          src: /assets/svg/pgsql.svg
      title: PostgreSQL 教程
      details: 最强大的开源关系型数据库
      link: /sql/pgsql/index
    - icon:
          src: /assets/svg/php.svg
      title: PHP 教程
      details: PHP语言解释器
      link: /php/index
---
