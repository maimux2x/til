## app/models/membership.rb

User / Room / Membership の関係性

1. 関連の定義

```ruby
# User モデル
has_many :memberships, dependent: :delete_all
has_many :rooms, through: :memberships
```

```ruby
# Room モデル
has_many :memberships, dependent: :delete_all
has_many :users, through: :memberships
belongs_to :creator, class_name: "User"
```

```ruby
# Membership モデル
belongs_to :room
belongs_to :user
```

`User` と `Room` は `Membership` を通して多対多の関係

- ユーザーは複数のルームに参加できる
- ルームには複数のユーザーが参加できる

| モデル     | 役割             | 主な属性                            |
|------------|------------------|-------------------------------------|
| User       | チャットの参加者 | name, email, status                 |
| Room       | チャットルーム   | name, type, creator_id              |
| Membership | 参加関係 + 状態  | involvement, unread_at, connections |

`Membership` が参加状態を管理している

| 属性         | 意味                                                    |
|--------------|---------------------------------------------------------|
| involvement  | 通知設定（everything / mentions / nothing / invisible） |
| unread_at    | 未読メッセージの日時                                    |
| connections  | 現在の接続数（Action Cable）                            |
| connected_at | 接続開始日時                                            |

```ruby
# app/models/membership.rb:9
enum :involvement, %w[ invisible nothing mentions everything ].index_by(&:itself), prefix: :involved_in
```

```ruby
# Step 1: 配列を作成
%w[ invisible nothing mentions everything ]
# => ["invisible", "nothing", "mentions", "everything"]

# Step 2: index_by(&:itself) でハッシュに変換
%w[ invisible nothing mentions everything ].index_by(&:itself)
# => {
#      "invisible"  => "invisible",
#      "nothing"    => "nothing",
#      "mentions"   => "mentions",
#      "everything" => "everything"
#    }
```

Rails の enum の書き方

```ruby
# 方法1: 配列（値は自動で 0, 1, 2... になる）
enum :involvement, [:invisible, :nothing, :mentions, :everything]
# DB値: invisible=0, nothing=1, mentions=2, everything=3

# 方法2: ハッシュ（値を明示的に指定）
enum :involvement, { invisible: "invisible", nothing: "nothing", ... }
# DB値: invisible="invisible", nothing="nothing", ...
```

Connectable をモジュールとして切り出す意図

責務の分離

Membership モデル
本体（membership.rb）
参加関係の基本機能（involvement, unread_at, read）

Connectable（connectable.rb）
接続状態の管理（connected_at, connections）

Membership の責務が2つに分かれている：
- 「誰がどのルームに参加しているか」（本体）
- 「現在接続しているか」（Connectable）

モデルが肥大化せず、見通しが良くなる。
