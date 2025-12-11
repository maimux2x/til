## 仮想環境でGNOME

eselect profile list
`[2]` -> `[6]` に変更する

sudo eselect profile set 6
sudo emerge -avuDN @world
循環参照がおきると良くない
sudo USE=-tiff emerge -av1 libwebp
USEフラグで一時的にtiffを無効にしてlibwebpを入れる
sudo emerge -av gnome-light
sudo systemctl enable --now gdm

ターミナルを立ち上げて
sudo systemctl disable --now systemd-networkd
sudo systemctl enable ---now NetworkManager
仮想マシンのため、PCのネットワークと有線接続されているイメージ
sudo emerge -av spice-vdagent
