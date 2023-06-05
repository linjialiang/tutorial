// .prettierrc.cjs 或者 .prettierrc.js
module.exports = {
  // 一行最多 120 字符
  printWidth: 120,
  // 使用 2 个空格缩进
  tabWidth: 2,
  // 不使用缩进符，而使用空格
  useTabs: false,
  // 行尾需要有分号
  semi: true,
  // 使用单引号
  singleQuote: true,
  // 对象的 key 仅在必要时用引号
  quoteProps: 'as-needed',
  // jsx 不使用单引号，而使用双引号
  jsxSingleQuote: false,
  // 末尾需要有逗号
  trailingComma: 'all',
  // 大括号内的首尾需要空格
  bracketSpacing: true,
  // jsx 标签的反尖括号需要换行
  bracketSameLine: false,
  // 箭头函数，只有一个参数的时候，也需要括号
  arrowParens: 'always',
  // 每个文件格式化的范围是文件的全部内容
  rangeStart: 0,
  rangeEnd: Infinity,
  // 不需要写文件开头的 @prettier
  requirePragma: false,
  // 不需要自动在文件开头插入 @prettier
  insertPragma: false,
  // 使用默认的折行标准
  proseWrap: 'preserve',
  // HTML 中认为空格是不敏感的，用于阻止标签总是被分离
  htmlWhitespaceSensitivity: 'ignore',
  // vue 文件中的 script 和 style 内不用缩进
  vueIndentScriptAndStyle: false,
  // 换行符使用系统默认
  endOfLine: 'auto',
  // 格式化内嵌代码
  embeddedLanguageFormatting: 'auto',
  // 请注意：使用 vscode 编辑器，指定语法的 tabWidth 就不需要再 prettier 设置，
  // 因为 vscode 可以让md文件识别到其它语法的 tabWidth ，而 prettier 无法让md文件是被其它语法的 tabWidth
  overrides: [
    {
      files: ['*.md'],
      options: {
        tabWidth: 4,
      },
    },
    {
      files: ['*.php'],
      options: {
        tabWidth: 4,
      },
    },
  ],
};
