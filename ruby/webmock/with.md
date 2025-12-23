## with の役割

検証したい HTTP リクエストがどんな内容のときに `stub` を適用するかをしていするためのリクエスト条件フィルタ


以下の例の場合、 HTTP メソッド + URL が一致し、かつ `with` で指定した条件も一致した場合のみにマッチする

```ruby
stub_request(:post, "https://api.example.com/foo")
  .with(
    body: "...",
    headers: { ... },
    query: { ... }
  )
  .to_return(status: 200)
```

`with` を使わない場合、HTTP メソッド、URL が一致していれば、`header`, `body`, `query` の値は検証しないことを意味する。
同じ URL に複数のリクエストを投げる場合は不十分になってしまう。


```ruby
stub_request(:get, "https://api.example.com/foo")
```

### リクエスト body を限定する

```ruby
stub_request(:post, "https://api.example.com/foo")
  .with(
    body: {bar: "baz", piyo: "poyo"}
  )
```

`hash_including` を使うと条件を緩和することが可能。

### ヘッダを限定する

```ruby
stub_request(:get, "https://api.example.com/users")
  .with(
    headers: {
      'Authorization' => 'Bearer token123'
    }
  )
```

### クエリパラメータを限定する

`have_requested` を使って適切にリクエストされたかを検証する際、`body` は `stub-request` から省略できるけど、 `query` は URL の一部なので省略できない


```ruby
stub_request(:get, "https://api.example.com/users")
  .with(
    query: { page: "1", per_page: "20" }
  )
```

