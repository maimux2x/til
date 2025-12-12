## visudoコマンド

sudoersファイルを編集するコマンド。
`visudo` 以外のコマンドでsudoresは編集しちゃだめ。
実行の際はroot権限が必要。

```
# visudo
```

piyoユーザーに対して全てのコマンドをsudoで実行可能にする例

```
piyo ALL=(ALL) ALL
```

nanoの場合は`Ctrl + O`で変更を保存、`Ctrl + X`でファイルを閉じることができる
