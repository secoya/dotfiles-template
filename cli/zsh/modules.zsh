#!/bin/zsh
for file in $HOME/.homesick/repos/dotfiles/cli/zsh/modules.d/*; do
    source "$file"
done
