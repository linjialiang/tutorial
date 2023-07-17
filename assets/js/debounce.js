/**
 * 防抖函数
 *  - 第1次调用直接执行,然后等待delay后，才能delay直接执行
 * @param {object} func 函数
 * @param {int} delay 等待秒速
 * @param {boolean} immediate 是否开启复杂的防抖函数
 * @returns
 */
function debounce(func, delay, immediate = true) {
  let timer;
  return function () {
    if (timer) clearTimeout(timer);
    if (immediate) {
      // 复杂的防抖函数
      // 判断定时器是否为空，如果为空，则会直接执行回调函数
      let firstRun = !timer;
      // 不管定时器是否为空，都会重新开启一个新的定时器,不断输入，不断开启新的定时器，当不在输入的delay后，再次输入就会立即执行回调函数
      timer = setTimeout(() => {
        timer = null;
      }, delay);
      if (firstRun) {
        func.apply(this, arguments);
      }
    } else {
      // 简单的防抖函数
      timer = setTimeout(() => {
        func.apply(this, arguments);
      }, delay);
    }
  };
}
