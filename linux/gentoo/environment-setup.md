## 仮想環境で Gentoo Linux の環境構築

```
$ emerge --ask app-emulation/gnome-boxes
$ rc-update add libvirtd default
$ rc-service libvirtd start
```

インストールISOを用意

```
$ wget https://bouncer.gentoo.org/fetch/root/all/releases/amd64/autobuilds/current-install-amd64-minimal/install-amd64-minimal.iso
```

### GNOME Boxes を起動して新規仮想マシン作成
gnome-boxes を起動。
「新規」 → 「ファイルを選択」で上記 ISO を指定。
OS が自動認識されない場合は「その他のOS」を選択。
メモリ（例: 4GB）とディスクサイズ（例: 20GB）を設定。
作成 → 起動。

### 通常の Gentoo インストール手順を実施
Boxes 内の仮想マシンコンソールから、
パーティション作成
stage3 展開
chroot
Portage 設定
カーネルビルド
grub 設定
※ ネットワークは通常 NAT 経由で動作するため、ping gentoo.org が通ればOK。

インストールを終えたら
ISO をアンマウント
仮想マシンを再起動
→ Gentoo がブートすれば成功
