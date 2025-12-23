## stub_request と have_requested

`stub_request` のみでは本当にリクエストが飛んだかは検証できない
リクエストが飛んだかまでを検証するためには `have_requested` と組み合わせる。

以下の例だと `stub_request` のみなため、リクエストが飛んだかは検証していない。

```ruby
stub_request(:post, 'example.com/foo').with(
  body: {
    bar: 'baz'
  }
)
stub_request(:post, 'example.com/foo').with(
  body: {
    bar: 'qux'
  }
)
http.post 'example.com/foo', body: {bar: 'baz'}
http.post 'example.com/foo', body: {bar: 'qux'}
```

`with` なしでリクエストが飛んだかのみを検証

```ruby
stub_request :post, 'example.com/foo'
http.post 'example.com/foo', body: {bar: 'baz'}
expect(WebMock).to have_requested(:post, 'example.com/foo')
```

URL を`stub` しておいて、`have_requested` 側で `with` を使ってリクエストの内容を検証する

```ruby
stub_request :post, 'example.com/foo'

http.post 'example.com/foo', body: {bar: 'baz'}
http.post 'example.com/foo', body: {bar: 'qux'}

expect(WebMock).to have_requested(:post, 'example.com/foo').with(
  body: {
    bar: 'baz'
  }
)
expect(WebMock).to have_requested(:post, 'example.com/foo').with(
  body: {
    bar: 'qux'
  }
)
```

stub するエンドポイントは一緒で、レスポンスが異なる場合可変長でレスポンスをまとめて記載できる。

```ruby
stub_request(:post, 'example.com/foo').and_return_json(
  {
    body: {
      status: 'ok'
    }
  },
  {
    body: {
      status: 'error'
    }
  }
)

res1 = http.post('example.com/foo', body: {bar: 'baz'})
res2 = http.post('example.com/foo', body: {bar: 'qux'})

expect(res1.json).to eq(status: 'ok')
expect(res2.json).to eq(status: 'error')

expect(WebMock).to have_requested(:post, 'example.com/foo').with(
  body: {
    bar: 'baz'
  }
)
expect(WebMock).to have_requested(:post, 'example.com/foo').with(
  body: {
    bar: 'qux'
  }
)
```
