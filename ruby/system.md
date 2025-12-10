## Kernel.#system

`Kernel.#system` は、Ruby から外部コマンドを実行するためのメソッド。

```ruby
system("ls")
```

コマンドが正常に終了した場合は `true` を返し、エラー終了した場合は `false` を返す。
実行自体に失敗した場合（コマンドが存在しないなど）は `nil` を返す。
