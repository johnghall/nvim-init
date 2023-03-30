#!/bin/bash

### Dependencies ###
if [[ $(uname -s) == "Darwin" ]]; then
    if ! command -v brew &> /dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    brew install zsh
    xcode-select --install
    brew install ninja libtool cmake pkgconfig gettext
elif [[ $(lsb_release -si) == "Ubuntu" ]]; then
    sudo apt update
    sudo apt install -y zsh
    sudo apt-get install ninja-build gettext libtool-bin cmake g++ pkg-config unzip curl
else
    echo "Unsupported operating system"
    exit 1
fi

### dotfiles ###
cp dotfiles/. ~

### zsh ###
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

### Neovim ###
git clone https://github.com/neovim/neovim
cd neovim
git checkout stable
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
cd .. && rm -rf neovim

# Configs
if [ -d ~/.config/nvim ]; then
  echo "Error: ~/.config/nvim directory already exists"
  exit 1
fi

mkdir -p ~/.config
cp -R nvim ~/.config

### tmux ###
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf
tmux start-server
tmux new-session -d
source ~/.tmux/plugins/tpm/scripts/install_plugins.sh
tmux kill-server

