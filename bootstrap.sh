#!/usr/bin/env bash

hash zsh 2>/dev/null || {
    echo >&2 "Zsh is not installed. Aborting."
    exit 1
}

if [ ! command -v starship &> /dev/null ]; then
  echo "Installing starship."
  curl -sS https://starship.rs/install.sh | sh
fi

REPOS="$HOME/.homesick/repos"

if [ ! -d "$REPOS/homeshick" ]; then
    echo "Installing Homeshick."
    git clone https://github.com/andsens/homeshick.git "$REPOS/homeshick"
fi

source "$REPOS/homeshick/homeshick.sh"

if [ ! -d "$REPOS/prezto" ]; then
    echo "Installing Prezto."
    homeshick clone sorin-ionescu/prezto
fi

if [ ! -d "$REPOS/dotfiles" ]; then
    echo "Installing dotfiles."
    homeshick clone CWSpear/dotfiles
fi

homeshick link

ZSH=`which zsh`

if [ $ZSH != $SHELL ]; then
    echo "Changing shell to Zsh."
    chsh -s $ZSH
fi

echo "Dotfiles away!"
