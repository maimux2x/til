## importmap の pin と pin_all_from

`pin`
- 個別ファイルを1つずつ登録（マッピング）するためのメソッド
- 名前（モジュール名）と実際のファイルパスを明示的に対応付ける

 ```ruby
pin "application"
pin "@hotwired/stimulus", to: "stimulus.min.js"
```

- `"application"` というモジュール名で `app/assets/builds/application.js`（デフォルト）を読み込む。
- `"@hotwired/stimulus"` というモジュール名で `stimulus.min.js` を読み込む。

`pin_all_from`
- ディレクトリ配下の複数ファイルをまとめて登録するためのメソッド。
- 第1引数で指定したディレクトリを走査し、見つかったすべての `.js` ファイルをモジュールとして pin する。
- `under:` オプションでモジュールの名前空間を設定する。

```ruby
pin_all_from "app/javascript/controllers", under: "controllers"
```

`app/javascript/controllers` 配下の `.js` ファイルをすべて pin する。
たとえば `app/javascript/controllers/hello_controller.js` はモジュール名 `"controllers/hello_controller"` として登録される。

つまり
`import { something } from "controllers/hello_controller"`
のように読み込めるようになる。
