#!/usr/bin/env bash

if type terraform &>/dev/null; then
  terraform() {
    AWS_SDK_LOAD_CONFIG=1 AWS_PROFILE=role command terraform "$@"
  }
fi
