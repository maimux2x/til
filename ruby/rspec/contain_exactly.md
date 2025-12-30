## contain_exactly matcher

実際の配列と期待される配列の要素順序は考慮せず、配列同士を比較するj。
配列には指定された全ての値が含まれている必要がある。

```ruby
expect([1, 2, 3]).to    contain_exactly(2, 3, 1) # pass
expect([:a, :c, :b]).to contain_exactly(:a, :c ) # fail
```
