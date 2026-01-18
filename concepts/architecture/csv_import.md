# ブログへの　CSV インポート機能の実装

## 要件

1行に日付とタイトルと本文を入れて1エントリ、それをファイル単位でまとめて管理画面からインポートできる（非同期で）。
管理画面でインポート履歴（成功N件/失敗M件）が見られる。

### 日付の扱い
`published_at` カラムを追加する

### 処理の流れ

```mermaid
sequenceDiagram
  Ember->>Ember: ファイルを選択
  Ember->>Rails: ファイルをアップロード
  Note over Rails: POST api/csv_import
  Rails->>ActiveStorage: ファイルを保存
  Rails->>SQLite: CSVImport 作成
  Rails->>SQLite: ImportCSVJob をエンキュー
  
  Note over SolidQueue: 非同期処理
  SQLite->>SolidQueue: ジョブ取得
  SolidQueue->>ActiveStorage: CSVファイルを取得
  SolidQueue->>SolidQueue: CSVをパース
  loop 各行を処理
    SolidQueue->>SQLite:Postレコードを保存
  end
  SolidQueue->>SQLite: CSVImport更新
  
  Ember->>Rails: インポート履歴をリクエスト
  Note over Rails: GET api/csv_import
  Rails->>SQLite: CSVImportを取得
  Rails->>Ember: インポート履歴を返す
```

```mermaid
classDiagram
  CSVImport "1" -- "0..1" ActiveStorage_Attachment : has_one_attached (file)
  ActiveStorage_Attachment "1" -- "1" ActiveStorage_Blob : belongs_to
  CSVImport "1" ..> "*" Post : creates
  CSVImportJob ..> CSVImport :proccesss
```
```mermaid
sequenceDiagram
    participant Ember
    participant ActiveStorage as Rails<br/>/rails/active_storage/direct_uploads
    participant CSVImports as Rails<br/>/api/csv_imports

    Note over Ember: ユーザーがファイル選択 → Import クリック

    rect rgb(240, 240, 255)
        Note over Ember,ActiveStorage: 1. DirectUpload（ファイルアップロード）
        Ember->>ActiveStorage: POST /rails/active_storage/direct_uploads
        Note right of Ember: Headers:<br/>Authorization: Bearer {token}<br/>Content-Type: application/json
        Note right of Ember: Body:<br/>{ blob: {<br/>  filename: "sample.csv",<br/>  content_type: "text/csv",<br/>  byte_size: 113,<br/>  checksum: "xxx"<br/>}}
        ActiveStorage-->>Ember: 200 OK
        Note left of ActiveStorage: Response:<br/>{ signed_id: "eyJfcmFpbHM..." }
    end

    rect rgb(255, 240, 240)
        Note over Ember,CSVImports: 2. CSVImport作成（signed_idを送信）
        Ember->>CSVImports: POST /api/csv_imports
        Note right of Ember: Headers:<br/>Authorization: Bearer {token}<br/>Content-Type: application/json
        Note right of Ember: Body:<br/>{ csv_import: {<br/>  file: "eyJfcmFpbHM..."<br/>}}
        CSVImports-->>Ember: 200 OK
        Note left of CSVImports: Response:<br/>{ id: 1, status: "pending" }
    end
```
