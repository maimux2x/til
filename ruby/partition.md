## Enumerable#partition

`Enumerable#partition` は、ブロックの真偽で要素を2つの配列に分けるメソッド。

https://docs.ruby-lang.org/ja/latest/method/Enumerable/i/partition.html

```ruby
nums = [1, 2, 3, 4, 5, 6]

even, odd = nums.partition { |n| n.even? }
# even => [2, 4, 6]
# odd  => [1, 3, 5]
```
