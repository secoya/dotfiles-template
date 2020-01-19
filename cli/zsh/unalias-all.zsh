#!/bin/zsh
unsetopt CORRECT
typeset -a builtin_aliases
builtin_aliases=(
    'run-help' 'which-command'
)
while IFS= read -r a; do
    key=${a%%\=*}
    value=${a#*\=}
    if [[ ${builtin_aliases[(r)$key]} != $key ]]; then
        unalias "$key"
    else
        continue
    fi
done <<<$(alias)
