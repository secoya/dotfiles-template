# Pure selection awesomeness
# https://stackoverflow.com/a/12193631/339505
# https://stackoverflow.com/a/30899296/339505

set -a killring ''

_zsh_selection_activate_keys() {
    bindkey '"' quote-region
}

_zsh_selection_deactivate_keys() {
    bindkey -r '"'
}

_zsh_selection_delregion() {
    if ((REGION_ACTIVE)) then
        # Kill region without adding it to the buffer
        local current_yank=$CUTBUFFER
        zle kill-region
        if type pbcopy &>/dev/null; then
            zle copy-region-as-kill -- "$(pbpaste)"
        elif type xsel &>/dev/null; then
            zle copy-region-as-kill -- "$(xsel -bo)"
        else
            zle copy-region-as-kill -- "$current_yank"
        fi
    else
        local widget_name=$1
        shift
        zle "$widget_name" -- "$@"
    fi
}

_zsh_selection_deselect() {
    if ((REGION_ACTIVE)) then
        ((REGION_ACTIVE = 0))
        _zsh_selection_deactivate_keys
    fi
    local widget_name=$1
    shift
    zle "$widget_name" -- $@
}

_zsh_selection_select() {
    if ! ((REGION_ACTIVE)) then
        zle set-mark-command
        _zsh_selection_activate_keys
    fi
    local widget_name=$1
    shift
    zle "$widget_name" -- "$@"
}

_zsh_selection_copy() {
    if ((REGION_ACTIVE)) then
        zle copy-region-as-kill
        if type pbcopy &>/dev/null; then
            printf -- "%s" "$CUTBUFFER" | pbcopy
        elif type xsel &>/dev/null; then
            printf -- "%s" "$CUTBUFFER" | xsel -bi
        fi
    fi
}

_zsh_selection_paste() {
    if ((REGION_ACTIVE)) then
        local current_yank=$CUTBUFFER
        zle kill-region
        zle copy-region-as-kill -- "$current_yank"
        _zsh_selection_deactivate_keys
    fi
    if type pbcopy &>/dev/null; then
        zle copy-region-as-kill -- "$(pbpaste)"
    elif type xsel &>/dev/null; then
        zle copy-region-as-kill -- "$(xsel -bo)"
    fi
    zle yank
}

_zsh_selection_cut() {
    if ((REGION_ACTIVE)) then
        zle kill-region
        _zsh_selection_deactivate_keys
        if type pbcopy &>/dev/null; then
            printf -- "%s" "$CUTBUFFER" | pbcopy
        elif type xsel &>/dev/null; then
            printf -- "%s" "$CUTBUFFER" | xsel -bi
        fi
    else
        local widget_name=$1
        shift
        zle "$widget_name" -- "$@"
    fi
}

if uname | grep -q Linux; then
  bindkey $'\e[1;3D' backward-word
  bindkey $'\e[1;3C' forward-word
  bindkey $'\e[1~' beginning-of-line
  bindkey $'\e[4~' end-of-line
  bindkey $'\e[1;7F' backward-delete-word
else
  # MacOS
  bindkey $'\e[1;9D' backward-word
  bindkey $'\e[1;9C' forward-word
  bindkey $'\e[1;5D' beginning-of-line
  bindkey $'\e[1;5C' end-of-line
  bindkey $'\e[1;7F' backward-delete-word
fi


for key     kcap    seq         mode      widget (
    left    kcub1   $'\eOD'     deselect  backward-char
    right   kcuf1   $'\eOC'     deselect  forward-char
    end     kend    $'\eOF'     deselect  end-of-line
    end2    x       $'\e4~'     deselect  end-of-line
    home    khome   $'\eOH'     deselect  beginning-of-line
    home2   x       $'\e1~'     deselect  beginning-of-line
    cleft   x       $'\e[1;3D'  deselect  backward-word
    cright  x       $'\e[1;3C'  deselect  forward-word
    sleft   kLFT    $'\e[1;2D'  select    backward-char
    sright  kRIT    $'\e[1;2C'  select    forward-char
    send    kEND    $'\e[1;2F'  select    end-of-line
    send2   x       $'\e[4;2~'  select    end-of-line
    shome   kHOM    $'\e[1;2H'  select    beginning-of-line
    shome2  x       $'\e[1;2~'  select    beginning-of-line
    csleft  x       $'\e[1;6D'  select    backward-word
    csright x       $'\e[1;6C'  select    forward-word
    msleft  x       $'\e[1;4D'  select    backward-word
    msright x       $'\e[1;4C'  select    forward-word
    msleft  x       $'\e[1;10D' select    backward-word
    msright x       $'\e[1;10C' select    forward-word
    csend   x       $'\e[1;6F'  select    end-of-line
    cshome  x       $'\e[1;6H'  select    beginning-of-line
    del     kdch1   $'\e[3~'    delregion delete-char
    bs      x       $'^?'       delregion backward-delete-char
    mx      x       $'^[x'      cut       delete-char
    mv      x       $'^[v'      paste     yank
    mc      x       $'^[c'      copy      copy-region-as-kill
  ) {
	eval "_zsh_selection_$key() {
		_zsh_selection_$mode $widget \$@
	}"
    zle -N _zsh_selection_$key
    bindkey ${terminfo[$kcap]-$seq} _zsh_selection_$key
}
