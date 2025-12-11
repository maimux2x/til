## accessor の定義

こういう書き方もできそう

```ruby
ABILITIES = %i[strength dexterity constitution intelligence wisdom charisma]
attr_reader *ABILITIES
```
