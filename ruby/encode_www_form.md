## URI.encode_www_form

`URI.encode_www_form` は、ハッシュや配列をクエリ文字列に変換するメソッド。
https://docs.ruby-lang.org/ja/latest/method/URI/s/encode_www_form.html

```ruby
require "uri"

params = { q: "ruby", page: 2 }
URI.encode_www_form(params)
# => "q=ruby&page=2"
```
