## params.expect

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
