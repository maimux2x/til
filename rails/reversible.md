## migration で rerversible を使う

マイグレーション が複雑な場合、 `change` で逆進できなくなることがあり、そのような場合に `reversible` を使って `change` メソッドの中で「進める時だけ」「戻す時だけ」の処理を分けて書くことができる。
SQLの生のクエリを書くことも可能。

```ruby
class ExampleMigration < ActiveRecord::Migration[8.0]
  reversible do |direction|
    direction.up do
     # distributors_viewを作成する
      execute <<-SQL
        CREATE VIEW distributors_view AS
        SELECT id, zipcode
        FROM distributors;
      SQL
    end

    direction.down do
      execute <<-SQL
        DROP VIEW distributors_view;
      SQL
   end
end
```

既存テーブルに非null制約のカラムを追加して且つ値も埋めたい場合は、`add_column` 時点で `null: false` を指定するとそこで落ちてしまうため、`reversible` を挟んで分けて書く。


```ruby
def change
  add_column :users, :foo, :integer

  reversible do |dir|
    dir.up do
      execute <<~SQL
        UPDATE users SET foo = 1;
      SQL
    end
  end

  change_column_null :users, :foo, false
end
```
