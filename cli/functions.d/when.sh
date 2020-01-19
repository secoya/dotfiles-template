#!/bin/bash

if [[ $SHELL = *zsh ]]; then
    function when {
        local search="$*"
        local entry
        local exec_epoch
        local exec_time
        local full_command
        IFS=$'\n'
        for entry in $(grep -F "$search" "$HISTFILE" | grep -Fv '0;when' | tail -n 5); do
            exec_epoch=$(sed 's/: \([0-9]\{9,\}\):.*/\1/' <<<"$entry")
            exec_time=$(epoch "$exec_epoch")
            full_command=$(sed 's/: [0-9]\{9,\}:0;\(.*\)/\1/' <<<"$entry")
            printf "%s: %s\n" "$exec_time" "$full_command"
        done
    }
fi
