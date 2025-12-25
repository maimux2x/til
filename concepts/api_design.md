## API の設計

ユーザーを検索するための URI が提供されている場合、検索を `GET` するのはおかしい

```
GET /users
GET /users?uid=foo

POST /users/search
```
