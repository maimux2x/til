## raise_error mathcer

このマッチャーを使うと例外が発生したかを例外クラスと共に確認することができる

https://rspec.info/features/3-13/rspec-expectations/built-in-matchers/raise-error/

```ruby
expect { foo.bar }.to raise_error(BazError)
```
