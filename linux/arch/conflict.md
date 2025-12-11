## Arch Linux ファイルの競合が発生した場合

1. 衝突しているファイルを確認

```
$ ls /usr/lib/firmware/nvidia/
```

2. 競合ファイルを削除してからパッケージ更新を再実行

```
$ sudo rm -rf {PATH}
```

強制上書きも可能

```
$ sudo pacman -Syu --overwrite "usr/lib/firmware/nvidia/*"
```
