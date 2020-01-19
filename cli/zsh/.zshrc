#
# Executes commands at the start of an interactive session.
#

fpath=("$HOME/.homesick/repos/dotfiles/cli/zsh/completions" "${fpath[@]}")

if [[ $ZSH_FRAMEWORK == "oh-my-zsh" ]]; then
    # Let homeshick handle the updating
    DISABLE_AUTO_UPDATE="true"
    ZSH_TMUX_AUTOSTART=true
    export ZSH=$HOME/.homesick/repos/oh-my-zsh
    ZSH_CUSTOM=$HOME/.homesick/repos/dotfiles/oh-my-zsh-custom
    ZSH_THEME=${ZSH_THEME:-"agnoster"}
    # Use the same history file as prezto
    HISTFILE="${ZDOTDIR:-$HOME}/.zhistory"
    plugins+=(coffee colored-man-pages docker extract history-substring-search kubectl vagrant)
    if [[ "$(uname -a)" =~ 'Linux' ]]; then
        plugins+=(tmux)
    fi
    # Source oh-my-zsh
    source "$HOME/.homesick/repos/oh-my-zsh/oh-my-zsh.sh"
    unsetopt correct_all
    # Disable the automatic titling, it screws up tmux
    DISABLE_AUTO_TITLE=true
fi

# Source Prezto.
if [[ $ZSH_FRAMEWORK == "prezto" ]]; then
    fpath=("${ZDOTDIR:-$HOME}/prompts" "${fpath[@]}")
    # Only set dirty check threshhold if no set
    if ! zstyle -s ':prompt:andsens:git:dirty' check-threshhold _check_threshhold; then
        zstyle ':prompt:andsens:git:dirty' check-threshhold 0.250
    fi
    unset _check_threshhold
    autoload -Uz "prompt_andsens_setup"

    source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
    source "${ZDOTDIR:-$HOME}/unalias-all.zsh"
    source "${ZDOTDIR:-$HOME}/modules.zsh"
fi

source "$HOME/.homesick/repos/dotfiles/cli/aliases.sh"
source "$HOME/.homesick/repos/dotfiles/cli/functions.sh"

if type homeshick > /dev/null 2>&1; then
    homeshick --quiet refresh 56 "homeshick dotfiles prezto" || true
fi

compinit -i
