#!/bin/bash

if [[ $(uname) == 'Darwin' && $TERM_PROGRAM == 'iTerm.app' ]]; then
  iterm-tab-color() {
    printf "\033]6;1;bg;red;brightness;%d\a" "$1"
    printf "\033]6;1;bg;green;brightness;%d\a" "$2"
    printf "\033]6;1;bg;blue;brightness;%d\a" "$3"
  }

  iterm-tab-reset() {
    printf "\033]6;1;bg;*;default\a"
  }

  iterm-color-ssh() {
    if [ -t 1 ]; then
      if [ -n "$ITERM_SESSION_ID" ]; then
        trap "iterm-tab-reset" INT EXIT
        if [[ $@ == *.local* ]]; then
          iterm-tab-color 182 211 93
        else
          iterm-tab-color 249 121 114
        fi
      fi
    fi
    ssh "$@"
  }

  if type compdef &> /dev/null; then
    compdef _ssh iterm-color-ssh=ssh
  fi

  alias ssh=iterm-color-ssh
fi

