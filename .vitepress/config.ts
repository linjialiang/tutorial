import { defineConfig } from 'vitepress';
import environmentNav from './nav/environment';
import tutorialNav from './nav/tutorial';
import webNav from './nav/web';
import sidebar from './sidebar/main';

// https://vitepress.dev/reference/site-config
export default defineConfig({
  base: '/',
  lang: 'zh-CN',
  title: 'PHP Environment',
  description: '基于Debian的php环境搭建教程',
  head: [['link', { rel: 'icon', href: '/favicon.ico' }]],
  lastUpdated: true,
  markdown: { lineNumbers: false },
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    logo: '/logo.png',
    lastUpdatedText: '最近更新',
    socialLinks: [{ icon: 'github', link: 'https://github.com/linjialiang/php-environment.git' }],
    editLink: {
      pattern: 'https://github.com/linjialiang/php-environment/main/:path',
      text: '在 github 上编辑',
    },
    search: { provider: 'local' },
    nav: [
      { text: '主页', link: '/' },
      { text: '环境搭建', items: environmentNav },
      { text: '后端', items: tutorialNav },
      { text: '前端', items: webNav },
      { text: '其他', link: '/other/' },
    ],
    sidebar: sidebar,
  },
});
