## Rails 8の認証機能

Rails 8で簡易的な認証機能を利用できるようになった。
新規ユーザーの追加は前提とされてなさそうで？consoleからデータを更新する必要がある。
個人ブログの裏側とかdeviseを使うほどじゃない時とかに使えそう。

```
$ bin/rails generate authentication
$ bin/rails db:create db:migrate
$ rails c
>> User.create(email_address: "test@example.com", password: "password")
```

認証機能を導入すると `User` モデル、`Current` モデル、`Session` モデルがセットアップされる。

ブログの場合、記事一覧と記事の内容だけは認証を除外したいとなる。
その場合は該当のコントローラに`allow_unauthenticated_access(only: %i[index show])` のように除外したいアクションを指定する。
除外されていないページにアクセスしようとするとログインを求められる。

`current_user` メソッドを使いたかったので `app/controllers/application_controller.rb` を以下のように修正した。

```ruby
class ApplicationController < ActionController::Base
include Authentication
helper_method :current_user
allow_browser versions: :modern

private

def current_user
 @current_user ||= Current.user if Current.session
end
end
```
