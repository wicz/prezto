#
# Provides Git aliases and functions.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Return if requirements are not found.
if (( ! $+commands[git] )); then
  return 1
fi

# Load dependencies.
pmodload 'helper'

# Source module files.
source "${0:h}/alias.zsh"

LINKS=(gitignore gitconfig)

for file in $LINKS
do
  if [[ ! -L "$HOME/.$file" ]]
  then
    ln -s "${0:h}/${file:t}" $HOME/.$file
  fi
done

