#!/bin/bash

# sudoを使用するかどうかのフラグ
USE_SUDO=false

# 引数を解析
for arg in "$@"
do
    case $arg in
        --sudo)
        USE_SUDO=true
        shift # 引数をシフト
        ;;
        *)
        # 他のオプションがある場合の処理
        ;;
    esac
done

# sudoを使用する場合はコマンドに付ける
SUDO_CMD=""
if $USE_SUDO; then
  SUDO_CMD="sudo"
fi

# upgrade
$SUDO_CMD apt update
$SUDO_CMD apt upgrade

# install
$SUDO_CMD apt install -y \
curl \
neovim

# 以下は実行ユーザーの$HOMEに配置するため、sudoは不要
# vimplug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# make symbolic link ($HOME/.config)
mkdir -p "$HOME/.config"
if [ -e "$HOME/.config/nvim" ]; then
  rm -rf "$HOME/.config/nvim"
fi
ln -sfr "$HOME/dotfiles-neovim/.config/nvim" "$HOME/.config/nvim"
