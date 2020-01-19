#
# Executes commands at login pre-zshrc.
#

source "$HOME/.homesick/repos/dotfiles/cli/profile"

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

#
# Determine which framework to use
#

if [[ -z $ZSH_FRAMEWORK ]]; then
    # Default to prezto
    if [[ -e "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
        ZSH_FRAMEWORK='prezto'
    elif [[ -e $HOME/.homesick/repos/oh-my-zsh/oh-my-zsh.sh ]]; then
        ZSH_FRAMEWORK='oh-my-zsh'
    fi
fi

#
# Paths
#

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the the list of directories that cd searches.
# cdpath=(
#   $cdpath
# )

# Set the list of directories that Zsh searches for programs.
path=($path)
