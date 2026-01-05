`insert_all` や `upsert_all` は ActiveRecord のバリデーションを通らないため、値の検証が必要な場合はデータベースの CHECK 制約を活用する。

```ruby
add_check_constraint :product, 'price >= 0'
```
