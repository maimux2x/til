## params.expect

Strong Parameters のためのメソッド。
パラメータを必須化(`require`)と許可（`permit`）を同時に行って、これまでよりも安全かつ宣言的に扱えるようにしたもの。

`params.expect` はパラメータを取り出すときに必須チェックと許可チェックを同時に行って、許可済みのパラメータとして返すという動きをする。
従来の `params.require(:foo).permit(:bar)` に相当する。


```ruby
params = ActionController::Parameters.new(foo: {bar: 1})
# => #<ActionController::Parameters {"foo" => {"bar" => 1}} permitted: false>

params.expect(foo: [:bar])
# => #<ActionController::Parameters {"bar" => 1} permitted: true>

params.expect(foo: [:bar])[:bar]
# => 1

# パラメータの値が nil であっても params.expect 自体は true
params = ActionController::Parameters.new(foo: {bar: nil})
# => #<ActionController::Parameters {"foo" => {"bar" => nil}} permitted: false>

params.expect(foo: [:bar])
# => #<ActionController::Parameters {"bar" => nil} permitted: true>

!!params.expect(foo: [:bar])
# => true
```
