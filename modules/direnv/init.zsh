# Return if requirements are not found.
if (( ! $+commands[direnv] )); then
  return 1
fi

# Load dependencies.
pmodload 'helper'

eval "$(direnv hook $SHELL)"

