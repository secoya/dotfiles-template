#!/bin/bash

function vcmount {
  local vault=$1
  local password
  local veracrypt=veracrypt
  if ! type "$veracrypt" &>/dev/null; then
    veracrypt="/Applications/VeraCrypt.app/Contents/MacOS/VeraCrypt"
  fi
  sudo -v
  printf "Enter password for %s: " "$vault"
  read -rs password
  printf "\\n"
  if "$veracrypt" --text --non-interactive --stdin "$vault" <<<"$password"; then
    trap vcunmount ERR
    printf "Volume mounted, press Enter to unmount"
    read -r
    sudo -v
    vcunmount "$vault"
  else
    printf "Failed to mount volume\\n"
    return 1
  fi
}

function vcunmount {
  trap - ERR
  local vault=$1
  local veracrypt=veracrypt
  if ! type "$veracrypt" &>/dev/null; then
    veracrypt="/Applications/VeraCrypt.app/Contents/MacOS/VeraCrypt"
  fi
  if "$veracrypt" --text --non-interactive --dismount "$vault"; then
    printf "Volume unmounted\\n"
    return 0
  else
    printf "Failed unmounting volume\\n"
    return 1
  fi
}
