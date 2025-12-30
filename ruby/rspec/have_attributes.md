## have_attributes matcher

オブジェクトの属性が期待される属性と一致することを指定できる

```ruby
person = Person.new("Jim", 32)
expect(person).to have_attributes(:name => "Jim", :age => 32)
```
