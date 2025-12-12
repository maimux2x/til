## index_byを使用してオブジェクトをハッシュ化する

https://api.rubyonrails.org/classes/Enumerable.html#method-i-index_by

```ruby
Status.all.index_by { |status| sutatus.name }
>, # => {"tenure"=>#<Status id: 1, ...>, "leave_of_absence"=><Status id: 2, ...>, "separation_from_employment"=><Status id:3, ...>
```

https://blog.aiandrox.com/posts/tech/2021/03/31/

`index_by`がどんな場合に活用できるかあまりイメージが湧いていなかったけれど、N＋1の解消に活用したのでまとめておく。

```
Message -< View >- User

message has_many views
user has_many views
```

```ruby
class ViewController < ApplicationController
  def index
    @message = Message.find(params[:id])
    @view = View.includes(:user, :message).where(message_id: @message.id)
    @users = User.all
  end
end
```

```ruby
- @users.each do |user|
  - view = @view.where(user_id: user.id) # => N+1
```

`each`内でレコードの検索処理を書いたらコードの見直しサイン。
見直しのための一つの解決策として`index_by`で使用するレコードを事前にハッシュの形に加工する。

```ruby
class MessagesController < ApplicationController
  def index
    @messages = Message.find(params[:id])
    @messages_assoc = View.includes(:user, :message).where(message_id: @message.id).index_by(&:user_id)
  end
end
```

```ruby
- @users.each do |user|
  - view = @message_assoc[user.id]
```

`index_by`を利用することで発行されるクエリは各テーブル1回ごとになって、以下のように指定したkeyに対してオブジェクトをvalueとしたハッシュを作成することができる。

```
irb(main)> message_assoc
=>
{1=>
#<View:0x00...
 id:25,
 message_id:2,
 user_id: 3
 ・
 ・
 ・
```
