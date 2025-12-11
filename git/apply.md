## applyによるパッチの適用
`git diff` で作ったパッチをブランチに適用したい場合、`git apply` を使用する。
パッチが `/tmp/sample.patch` にある場合は以下のように実行する。

```
$ git apply /tmp/sample.patch
```

`git apply` はコミットを作成しないため、実行後はその変更をステージしてコミットする必要がある。
