# Return if requirements are not found.
if (( ! $+commands[pg_ctl] )); then
  return 1
fi

# Load dependencies.
pmodload 'helper'

export MONGODB_CONFIG="/usr/local/etc/mongod.conf"

# Source module files.
source "${0:h}/alias.zsh"

