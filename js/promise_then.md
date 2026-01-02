## Promise.prototype.then()

`then()`は「Promiseが完了したら、この処理を実行してね」の用途で使う。
引数には関数を渡す必要がある。
関数で包むことで「後で呼び出せる状態」にしている。

コールバックの時も同じ考え方をしている。

```javascript
// コールバック版
db.run("CREATE TABLE...", () => {
  console.log("完了");  // 関数の中に書く
});

// Promise版
run(db, "CREATE TABLE...").then(() => {
  console.log("完了");  // 関数の中に書く
});
```

どちらも「処理を関数で包んで渡す」ことで、「今じゃなくて、完了したら実行する」を表している。
