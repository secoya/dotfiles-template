#!/bin/bash

# git
alias add='git add'
alias status='git status -s'
alias commit='git commit'
alias push='git push'
alias pull='git pull'

# Use 1024 byte humanized block sizes for df & du
alias df='df -kh'
alias du='du -kh'

if [ "$(uname)" = 'Darwin' ]; then
    # macOS ls colors are enable with CLICOLOR=1
    alias ls='ls -h'
    alias p4merge='/Applications/p4merge.app/Contents/Resources/launchp4merge'
    alias tar='COPYFILE_DISABLE=true tar'
fi

if [ "$(uname)" = 'Linux' ]; then
    alias ls='ls -h --color=auto'
    alias canhaz='sudo apt-get install --no-install-recommends'
    alias a2r='sudo /etc/init.d/apache2 reload'
fi
if [ -e '/usr/local/bin/nano' ]; then
    alias nano='/usr/local/bin/nano'
fi

# Navigation
alias 1='cd +1'
alias 2='cd +2'
alias 3='cd +3'
alias 4='cd +4'

# ls - needs to got below the linux test
alias l='ls -l'
alias ll='ls -la'

noglobs=(jq)
for cmd in "${noglobs[@]}"; do
    eval "alias $cmd=\"noglob $cmd\""
done

unset cmd
