## deep_symbolize_keys

ハッシュのキーをすべてシンボルに変換するだけでなく、ネストされたハッシュ内のキーも再帰的にシンボルに変換してくれるメソッド

```ruby
params = {
 "user" => {
   "name" => "Alice",
   "details" => {
     "age" => "15",
     "country" => "WonderLand"
   }
 }
}

symbolized = params.deep_symbolize_keys

puts symbolized
# =>
# {
#   :user => {
#     :name => "Alice",
#     :details => {
#       :age => "15",
#       :country => "WonderLand"
#     }
#   }
# }
```

https://api.rubyonrails.org/classes/Hash.html#method-i-deep_symbolize_keys
