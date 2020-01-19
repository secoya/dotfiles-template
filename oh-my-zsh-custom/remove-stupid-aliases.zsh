#!/bin/zsh
remove_stupid_aliases () {
  local -a remove_these
  remove_these=('1' '2' '3' '4' '5' '6' '7' '8' '9' '_' \
                'afind' 'brews' 'bubc' 'bubo' 'bubu' 'cfp' 'cfpc' \
                'd' 'md' 'ofd' 'please' 'po' 'pu' 'rd' 'run' 'x')
  for a in ${remove_these[@]}; do
    type $a > /dev/null 2>&1 && unalias $a
  done
}
remove_stupid_aliases
