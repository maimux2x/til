## app/models/room.rb

2行目から18行目は memberships 関連に対してメソッドが定義されている。

[関連付けの拡張](https://railsguides.jp/association_basics.html#%E9%96%A2%E9%80%A3%E4%BB%98%E3%81%91%E3%81%AE%E6%8B%A1%E5%BC%B5)

```ruby
has_many :memberships, dependent: :delete_all do
  def grant_to(users)
    # ...
  end

  def revoke_from(users)
    # ...
  end

  def revise(granted: [], revoked: [])
    # ...
  end
end
```

room.memberships に対して直接メソッドを呼び出すことが可能。

```ruby
room = Room.find(1)

# 通常の has_many メソッド
room.memberships.count
room.memberships.where(user_id: 5)

# 拡張されたカスタムメソッド
room.memberships.grant_to(users)      # ユーザーにアクセス権を付与
room.memberships.revoke_from(users)   # アクセス権を剥奪
room.memberships.revise(granted: [...], revoked: [...])  # 一括更新
```

インスタンスメソッドを使った場合は、こんな感じになりそう。

```ruby
has_many :memberships, dependent: :delete_all
has_many :users, through: :memberships

def grant_memberships_to(users)
  Membership.insert_all(
    Array(users).collect do |user|
      { room_id: id, user_id: user.id, involvement: default_involvement }
    end
  )
end

def revoke_memberships_from(users)
  memberships.destroy_by(user: users)
end

def revise_memberships(granted: [], revoked: [])
  transaction do
    grant_memberships_to(granted) if granted.present?
    revoke_memberships_from(revoked) if revoked.present?
  end
end
```
