## have_attributes matcher

オブジェクトの属性が期待される属性と一致することを指定できる
オブジェクトのメソッドを見る matcher

```ruby
person = Person.new("Jim", 32)
expect(person).to have_attributes(:name => "Jim", :age => 32)
```

```ruby
class Foo
  def x = 'x'
end

foo = Foo.new

expect(foo).to have_attributes(x: 'x')
```
