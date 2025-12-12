## ActiveRecord serialize
https://api.rubyonrails.org/classes/ActiveRecord/AttributeMethods/Serialization/ClassMethods.html#method-i-serialize

一部翻訳：
データベースにシリアライズされたオブジェクトとして保存し、同じオブジェクトにデシリアライズして取得する必要がある属性がある場合、このメソッドを使用してその属性名を指定すれば、シリアライズ処理は自動的に行われます。

```ruby
class User < ActiveRecord::Base
serialize :preferences, coder: JSON
end
```

string 型のカラムに任意の形式のデータを保存できるため、使用を避けた方がいいという記事があるけど、絶対に使ってはいけないというものではない。
いくつかの用途を検討して、`serialize` が妥当と判断する場合もあると考えられるため、手段の一つとして知っておくと良さそう。
