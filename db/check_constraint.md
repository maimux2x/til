## PostgreSQL の検査制約

### 検査制約とは

テーブル内の各行に対して論理式（boolean 条件）を満たしているかどうかを検査する仕組み

- `true` または `null` と評価される場合に許可される
- `false` の場合は制約違反としてエラーになる

### 基本的な構文

`CHECK(expression)` という形で指定する

```sql
CREATE TABLE products (
    product_no INTEGER,
    name TEXT,
    price NUMERIC CHECK (price > 0)
);
```

上記例の場合、 `price` は０より大きい値しか許可されない

### 名前付き制約

検査制約に名前をつけることで「エラーメッセージがわかりやすくなる」「後で制約を変更・削除しやすくなる」というメリットがある

```sql
CREATE TABLE products (
  product_no INTEGER,
  name TEXT,
  price NUMERIC
  CONSTRAINT positive_price CHECK (price > 0)
);
```

### 列制約とテーブル制約

```sql
CREATE TABLE products (
  product_no INTEGER,
  name TEXT,
  price NUMERIC CHECK (price > 0),
  discounted_price NUMERIC CHECK (discounted_price > 0),
  CHECK (price > discounted_price)
);
```

### NULL の扱い

検査式が NULL と評価される場合も制約は満たされたとみなされる

- `CHECK (price>0)` の場合、 `price=NULL` は制約違反にはならない
- `NULL` を禁止したい場合は、別途 `NOT NULL` 制約を使う

```sql
price NUMERIC NOT NULL CHECK (price > 0)
```

### 検査タイミング

PostgreSQL の検査制約は `INSERT/UPDATE` が実行された時に評価される
また、CHECK 制約の条件を `immutable` であると仮定しているため、関数の戻り値が変化するような式や他のテーブルを参照するような複雑な条件を含むものには向かない。
