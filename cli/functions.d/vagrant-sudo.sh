#!/bin/bash

if type vagrant &>/dev/null; then
    vagrant() {
        if [[ $@ == up* ]] || [[ $@ == reload* ]] || [[ $@ == destroy* ]]; then
            sudo echo "" > /dev/null && command vagrant "$@"
        else
            command vagrant "$@"
        fi
    }
fi
