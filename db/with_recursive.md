## PostgreSQL の WITH RECURSIVE

PostgreSQL の `WITH RECURSIVE` は、再帰的なクエリを書くための構文。

```sql
WITH RECURSIVE cte_name (column_list) AS (
-- 再帰の起点（初期部分）
initial_query

UNION ALL

-- 再帰部分（自分自身を参照）
recursive_query
)
SELECT * FROM cte_name;
initial_query
```

initial_query : 再帰の開始点を決める
recursive_query : `cte_name`（共通テーブル式）を再帰的に参照して次の階層を取得する。
UNION ALL : 初期部分と再帰部分を結合。`UNION` にすると重複が消えるため、使い分けが必要。

従業員テーブル `employees`

| id | name |manager_id|
|---|---|---|
| 1 | Alice | NULL |
| 2 | Bob | 1 |
| 3 | Carol | 1 |
| 4 | Dave | 2 |
| 5 | Ellen | 2 |

「Alice の部下をすべて取得する」クエリ

```sql
WITH RECURSIVE subordinates AS (
SELECT id, name, manager_id
FROM employees
WHERE name = 'Alice'

UNION ALL

SELECT e.id, e.name, e.manager_id
FROM employees e
INNER JOIN subordinates s ON e.manager_id = s.id
)
SELECT * FROM subordinates;
```

```
 id | name   | manager_id
 ----+--------+------------
   1 | Alice  | NULL
   2 | Bob    | 1
   3 | Carol  | 1
   4 | Dave   | 2
   5 | Ellen  | 2
```
