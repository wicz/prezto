# Return if requirements are not found.
if (( ! $+commands[pg_ctl] )); then
  return 1
fi

# Load dependencies.
pmodload 'helper'

export PGDATA="/usr/local/var/postgres"

# Source module files.
source "${0:h}/alias.zsh"

LINKS=(psqlrc)

for file in $LINKS
do
  if [[ ! -L "$HOME/.$file" ]]
  then
    ln -s "${0:h}/${file:t}" $HOME/.$file
  fi
done

