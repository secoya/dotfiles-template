#!/bin/bash

suscp() {
set -o pipefail
local __DOC__='Usage: suscp <ssh-host>:<src-path> [ <dest-path> ]'

if [[ -z "$1" ]]; then
    printf "%s\n" "$__DOC__"
    return 1
fi

local host="${1%:*}"
local rfile="${1#*:}"
local lfile="$2"

if [[ -z "$lfile" ]]; then
    lfile="$(basename "$rfile")"
elif [[ -d "$lfile" ]]; then
    lfile="$lfile/$(basename "$rfile")"
fi

printf 'Password:'
read -rs pass
printf "\n"

printf "Copying remote file:\n%s:%s\nto local destination:\n%s\nwith elevated rights\n" "$host" "$rfile" "$lfile"

local fsize

fsize=$(
(
cat <<EOSSH
$pass
stat --format='%s' '$rfile'
EOSSH
) | ssh "$host" -- "sudo -Ski 2> /dev/null" | tail -n1
    )

if [[ -z "$fsize" ]]; then
    printf "Unable to determine remote file size\n"
    return 1
fi

if type pv &> /dev/null; then
(
cat <<EOSSH
$pass
dd if='$rfile'
EOSSH
) | ssh "$host" -- "sudo -Ski 2> /dev/null" | pv -pers "$fsize" | dd of="$lfile" 2> /dev/null

else

(
cat <<EOSSH
$pass
dd if='$rfile'
EOSSH
) | ssh "$host" -- "sudo -Ski 2> /dev/null" | dd of="$lfile" 2> /dev/null

fi
}

if type compdef &> /dev/null; then
    compdef suscp=scp
fi
