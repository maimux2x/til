const str = "にわにはにわにわとりがいる";
console.log(str.replace("にわ", "niwa"));
console.log(str.replace(/にわ/, "niwa"));
console.log(str.replace(/にわ/g, "niwa"));