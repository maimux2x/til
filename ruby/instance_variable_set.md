## Object#instance_variable_set

インスタンス変数に値をセットする。
https://docs.ruby-lang.org/ja/latest/method/Object/i/instance_variable_set.html

```ruby
ABILITIES = %i[strength dexterity constitution intelligence wisdom charisma]
ABILITIES.each { instance_variable_set("@#{it}", rand(6)) }
# => [:strength, :dexterity, :constitution, :intelligence, :wisdom, :charisma]
```
