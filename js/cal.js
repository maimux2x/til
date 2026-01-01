import minimist from 'minimist';
const argv = minimist(process.argv.slice(2));

const year  = argv.y ?? new Date().getFullYear();
const month = argv.m ?? new Date().getMonth() + 1;

const lastDate = new Date(year, month, 0);
const days     = [];
const firstDay = new Date(year, month - 1, 1).getDay();

days.push(' '.repeat(firstDay * 3));

for (let i = 1; i <= lastDate.getDate(); i++) {
  days.push(String(i).padStart(2, ' ') + ' ');

  if (new Date(year, month - 1, i).getDay() === 6) {
    days.push("\n");
  }
}

const title = `${month}月 ${year}`;
console.log(title.padStart((21 + title.length) / 2));
console.log('日 月 火 水 木 金 土');
console.log(days.join(''));
