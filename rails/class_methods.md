## include したクラスにクラスメソッドを追加したい

### module ClassMethods を使う

```ruby
# app/models/concerns/publishable.rb
module Publishable
  extend ActiveSupport::Concern

    # includeされた時にクラスコンテキストで実行される
  included do
    scope :recent, -> { order(created_at: :desc) }
    validates :published_at, presence: true, if: :published?
  end

  module ClassMethods
    def published
      where(published: true)
    end

    def find_by_slug(slug)
      find_by(slug: slug)
    end
  end

  # インスタンスメソッド（普通にdefで書く）
  def publish!
    update!(published: true, published_at: Time.current)
  end
end
```

### class_methods を使う

```ruby
module Publishable
  extend ActiveSupport::Concern

  included do
    scope :recent, -> { order(created_at: :desc) }
    validates :published_at, presence: true, if: :published?
  end

  class_methods do
    def published
      where(published: true)
    end

    def find_by_slug(slug)
      find_by(slug: slug)
    end
  end

  def publish!
    update!(published: true, published_at: Time.current)
  end
end
```

```ruby
class Post < ApplicationRecord
  include Publishable
end

Post.published          # クラスメソッド
Post.recent             # スコープ（includedで定義）
Post.first.publish!     # インスタンスメソッド
```

### included の用途

`included` ブロックはモジュールが `include` された時点で、`include` したクラスのコンテキストで実行されます。

主な用途：
- スコープの定義
- バリデーションの追加 
- コールバックの設定
- 関連付けの定義 
