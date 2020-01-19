#!/usr/bin/env bash

if type kops &>/dev/null; then
  kops() {
    AWS_SDK_LOAD_CONFIG=1 AWS_PROFILE=kops command kops "$@"
  }
fi
