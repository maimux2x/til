## include matcher

文字列、配列、ハッシュなどの特定の期待するオブジェクトが1つ以上含まれていることを指定することができる。

```ruby
expect("a string").to include("a")
expect([1, 2]).to include(1)
expect(:a => 1, :b => 2).to include(:a)
```
