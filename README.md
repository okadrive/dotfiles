# 概要
- dotfiles 管理用リポジトリ
# 導入
```bash
git clone https://github.com/okadrive/dotfiles
cd dotfiles
./install.sh
```
## Tips
- Update submodules
```
git submodule update --init --recursive
```
- Save to Brewfile
```
brew bundle dump --file=~/Brewfile --force
```

```bash
brew bundle --file=~/Brewfile
```
