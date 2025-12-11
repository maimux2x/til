## curl コマンド

| オプション | 説明 |
|--|--|
| -X | HTTPメソッドを指定する |
| -H | headerを指定する |
| -d | HTTPリクエストでデータを送信する |
| -x | 転送中の詳細なログを 標準エラーに出力 |
| -o | 出力ファイル名を指定する |

ファイルからデータを読み込むときはパスの先頭に`@`をつける

```
$ curl https://example.com/api -X POST -H "Content-Type: application/json" -d '{"name": "John", "age": 30}' 
 
$ curl https://example.com/api -X POST -H "Content-Type: application/json" -d @tmp/sample.json

$ curl http://localhost:3000/api/posts -X POST -H "authorization: Bearer トークン"
```
