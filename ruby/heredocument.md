## ヒアドキュメントの開始ラベル

ヒアドキュメントでは、開始ラベル `<<識別子` が文法要素としての式にあたるため、開始ラベルを使ってヒアドキュメント全体を引数に渡したりレシーバにしたりできる。

https://docs.ruby-lang.org/ja/latest/doc/spec=2fliteral.html#here

```ruby
# 式の中に開始ラベルを書く
# method の第二引数には "    ヒアドキュメント\n" が渡される
method(arg1, <<LABEL, arg2)
 ヒアドキュメント
LABEL

# ヒアドキュメントをレシーバにメソッドを呼ぶ
p  <<LABEL.upcase
the lower case string
LABEL

# => "THE LOWER CASE STRING\n"
```
