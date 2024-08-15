#!/bin/bash

# upgrade
sudo dnf check-update
sudo dnf update
sudo dnf install epel-release

# install
sudo dnf install -y \
curl \
neovim

# 以下は実行ユーザーの$HOMEに配置するため、sudoは不要
# vimplug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# make symbolyclink ($HOME/.config)
mkdir -p "$HOME/.config"
if [ -e "$HOME/.config/nvim" ]; then
  rm -rf "$HOME/.config/nvim"
fi
ln -sfr "$HOME/dotfiles-neovim/.config/nvim" "$HOME/.config/nvim"
