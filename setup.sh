#!/bin/bash

### Dependencies ###
if [[ $(uname -s) == "Darwin" ]]; then
    if ! command -v brew &> /dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    brew install zsh fzf
    xcode-select --install
    brew install ninja libtool cmake pkgconfig gettext
elif [[ $(lsb_release -si) == "Ubuntu" ]]; then
    sudo apt update
    sudo apt install -y zsh fzf
    sudo apt-get install ninja-build gettext libtool-bin cmake g++ pkg-config unzip curl
elif [[ $(uname -n) == "archlinux" ]]; then
    paru -S zsh fzf base-devel cmake unzip ninja curl
else
    echo "Unsupported operating system"
    exit 1
fi

### dotfiles ###
ln -s "$(pwd)/dotfiles/.tmux.conf" ~/.tmux.conf
ln -s "$(pwd)/dotfiles/.spaceshiprc.zsh" ~/.spaceshiprc.zsh

### zsh ###
chsh -s $(which zsh)
export RUNZSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

if [ -z "$ZSH_CUSTOM" ]; then
  export ZSH_CUSTOM=~/.oh-my-zsh/custom
fi

echo "ZSH_CUSTOM is set to $ZSH_CUSTOM"

# Plugins
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab

# Edit ~/.zshrc
sed -i.bak 's/robbyrussell/spaceship/g' ~/.zshrc
sed -i.bak 's/plugins=(git)/plugins=(fzf-tab git zsh-autosuggestions zsh-syntax-highlighting web-search rust 1password colored-man-pages)/g' ~/.zshrc

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
ln -s "$(pwd)/nvim" ~/.config/nvim

tmux source ~/.tmux.conf

Blue='\033[0;34m'
Green='\033[0;32m'
echo "${Green}setup complete, cross your fingers and run ${Blue}exec \$SHELL"
