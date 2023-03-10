// g フラグを設定すると RegExp オブジェクトの test メソッドや exec メソッド、 String オブジェクトの match メソッド replace メソッドの挙動が変更されます

const str = "ABC あいう DE えお"
const alphabetsPattern = /[a-zA-Z]+/g;

console.log(alphabetsPattern.lastIndex);

const result1 = alphabetsPattern.exec(str);
console.log(result1[0]);
console.log(alphabetsPattern.lastIndex);
const result2 = alphabetsPattern.exec(str);
console.log(result2[0]);
console.log(alphabetsPattern.lastIndex);
const result3 = alphabetsPattern.exec(str);
console.log(result3);
console.log(alphabetsPattern.lastIndex);