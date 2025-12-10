## Hash#transform_values

全ての値に対してブロックを呼び出した結果で置き換えたハッシュを返す。
キーは変化しない。

```ruby
h = { a: 1, b: 2, c: 3 }
h.transform_values {|v| v * v + 1 }  #=> { a: 2, b: 5, c: 10 }

prices = { apple: 100, banana: 200, orange: 150 }
taxed_prices = prices.transform_values { |price| price * 1.1 }
 
puts taxed_prices
# => {:apple=>110.0, :banana=>220.0, :orange=>165.0}
```
