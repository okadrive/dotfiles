# 概要
- dotfiles 管理用リポジトリ
# 導入
```
$ git clone https://github.com/okadrive/dotfiles
$ cd dotfiles
$ ./install.sh
```
## Tips
- [最強の dotfiles 駆動開発と GitHub で管理する運用方法](https://qiita.com/b4b4r07/items/b70178e021bef12cd4a2)
## memo
- submodule のアップデート
```
$ git submodule update --init --recursive
```
- brewの再構築
```
$ brew file install Brewfile
```
