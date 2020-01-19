#!/bin/bash

function source_functions {
  local file
  for file in $HOME/.homesick/repos/dotfiles/cli/functions.d/*; do
      source "$file"
  done
}
source_functions
