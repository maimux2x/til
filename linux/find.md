## find コマンド

```
find [検索開始パス] [条件] [アクション]
```

カレントディレクトリ以下から `.rb` ファイルを探す

```
find . -name "*.rb"
```

ファイル名で検索する場合

```
-name "pattern"      # 大文字小文字を区別
-iname "pattern"     # 区別しない

find . -name "*.xml"
find . -iname "*.jpg"
```

ファイルタイプで検索する場合

```
-type f   # 通常ファイル
-type d   # ディレクトリ
-type l   # シンボリックリンク

find . -type d -name "test"
```
