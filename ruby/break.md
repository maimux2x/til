`break` は引数を指定するとそれを返す

```ruby
 [['a', 1], ['b', 2], ['c', 3]].find { it[1] == 1 ? it[0] : false }
 # => ["a", 1]
 [['a', 1], ['b', 2], ['c', 3]].find { it[1] == 1 ? break it[0] : false }
 # => "a"
 ```
