#!/bin/bash

if type slackcat &>/dev/null; then
  slacksend() {
    local user=$1
    local filepath=$2
    if [[ -z $filepath || -z $user ]]; then
      printf "Usage: slacksend USER FILEPATH\n"
      return 1
    fi
    case $user in
      initials) user=actual-username ;;
      *) ;;
    esac
    slackcat -c $user --filename "$(basename $filepath)" < "$filepath"
  }
fi
