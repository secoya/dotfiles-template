#!/usr/bin/env bash

function unlock_aws {
  local print_json=true
  if [[ $1 = '--env' ]]; then
    print_json=false
    shift
  fi
  local name=$1
  eval "$(gpg \
    --decrypt --quiet -r ___@yourdomain.com \
    "$HOME/.homesick/repos/dotfiles/config/aws/${name}.gpg"
  )"
  if $print_json; then
    printf '{\n  "Version": 1,\n  "AccessKeyId": "%s",\n  "SecretAccessKey": "%s"\n}\n' "$AWS_ACCESS_KEY_ID" "$AWS_SECRET_ACCESS_KEY"
  else
    printf 'export AWS_ACCESS_KEY_ID="%s"\nexport AWS_SECRET_ACCESS_KEY="%s"\n' "$AWS_ACCESS_KEY_ID" "$AWS_SECRET_ACCESS_KEY"
  fi
}

unlock_aws "$@"
