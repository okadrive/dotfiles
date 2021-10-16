# 設定を共有したいマシンで予めインストール済みのエクステンションを書き出しておく
# $code --list-extensions > extensions.txt

#.vscodeがインストールされている場合のみ
#if [ -e ~/Library/Application\ Support/Code/User ]; then
#    cd ~/Library/Application\ Support/Code/User

# for M1 Mac: .vscode-insiders
if [ -e ~/Library/Application\ Support/Code\ -\ Insiders/User ]; then
    cd ~/Library/Application\ Support/Code\ -\ Insiders/User
    # 前の設定をバックアップ
    mv settings.json settings.json.bak
    mv keybindings.json keybindings.json.bak
    mv snippets snippets.bak

    # ~/dotfiles/.vscode-insiders以下に他マシンと共有したい設定ファイルが置かれている想定
    # 元の設定ファイルの代わりにシンボリックリンクを置いておく
    ln -is ~/dotfiles/.vscode-insiders/settings.json
    ln -is ~/dotfiles/.vscode-insiders/keybindings.json
    ln -is ~/dotfiles/.vscode-insiders/snippets

    # 他マシンで書き出されたエクステンション一覧を使ってインストール
    for extension in `cat ~/dotfiles/.vscode-insiders/extensions.txt`; do
        #code --install-extension $extension
        code-insiders --install-extension $extension
    done
fi
