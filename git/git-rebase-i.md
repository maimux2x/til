## git rebase -i

過去のコミット履歴を編集することができる

```
$ git rebase -i
```

```
pick a1b2c3  Add login feature
pick d4e5f6  Fix typo
pick g7h8i9  Debug log
pick j1k2l3  Remove debug log
pick m4n5o6  Update README
```

### 並び替え
コミット順を入れ替えることが可能

```
pick d4e5f6  Fix typo
pick a1b2c3  Add login feature
```

### コミットをまとめる

squash

```
pick a1b2c3 Add login
s d4e5f6 Fix typo
```

2つのコミットをまとめ、最終的に1つのコミットメッセージを編集できる

fixup

```
pick a1b2c3 Add login
f d4e5f6 Fix typo
```

squash と似ているけど、メッセージ編集無しで上のコミットに結合できる

### コミットメッセージのみ変更

```
r a1b2c3 Add login
```

https://tracpath.com/docs/git-rebase/
