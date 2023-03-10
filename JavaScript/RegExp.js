const str = "ABC あいう DE えお"
const alphabetsPattern = /[a-zA-Z]+/;
const results = alphabetsPattern.exec(str);

console.log(results.length);
console.log(results[0]);
console.log(results.index);
console.log(results.input)
