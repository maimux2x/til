## credentials と key ファイル

### credentials とは

- 機密情報を安全に管理する仕組み
- DB パスワード、API キー、秘密鍵などを保存
- 実体は 暗号化された YAML ファイル

`config/credentials/*.yml.enc` : 中身は暗号化されている
`config/master.key` / `ENV["RAILS_MASTER_KEY"]` : 復号・編集に使われる

```yaml
aws:
  access_key_id: XXXXX
  secret_access_key: YYYYY
```

```ruby
Rails.application.credentials.aws[:access_key_id]
```

credentials を編集するには

```ruby
bin/rails credentials:edit
```

`master.key` を使って `.yml.enc` を復号

