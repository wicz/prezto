#
# Configures Ruby local gem installation, loads version managers, and defines
# aliases.
#
# Authors: Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Load RVM into the shell session.
if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
  # Unset AUTO_NAME_DIRS since auto adding variable-stored paths to ~ list
  # conflicts with RVM.
  unsetopt AUTO_NAME_DIRS

  # Source RVM.
  source "$HOME/.rvm/scripts/rvm"

# Load chruby and auto-switching (from homebrew)
elif [[ -n ${CHRUBY_PREFIX:=$(brew --prefix chruby)} ]]; then
  source $CHRUBY_PREFIX/share/chruby/chruby.sh
  source $CHRUBY_PREFIX/share/chruby/auto.sh

# Load manually installed rbenv into the shell session.
elif [[ -s "$HOME/.rbenv/bin/rbenv" ]]; then
  path=("$HOME/.rbenv/bin" $path)
  eval "$(rbenv init - --no-rehash zsh)"

# Load package manager installed rbenv into the shell session.
elif (( $+commands[rbenv] )); then
  eval "$(rbenv init - --no-rehash zsh)"

# Prepend local gems bin directories to PATH.
else
  path=($HOME/.gem/ruby/*/bin(N) $path)
fi

# Return if requirements are not found.
if (( ! $+commands[ruby] && ! ( $+commands[rvm] || $+commands[rbenv] ) )); then
  return 1
fi

#
# Aliases
#

# General
alias rb='ruby'

# Bundler
if (( $+commands[bundle] )); then
  alias rbb='bundle'
  alias rbbe='rbb exec'
  alias rbbi='rbb install'
  alias rbbl='rbb list'
  alias rbbo='rbb open'
  alias rbbp='rbb package'
  alias rbbu='rbb update'
  alias rbbI='rbbi \
    && rbb package \
    && print .bundle       >>! .gitignore \
    && print vendor/assets >>! .gitignore \
    && print vendor/bundle >>! .gitignore \
    && print vendor/cache  >>! .gitignore'
fi

LINKS=(aprc gemrc irbrc pryrc)

for file in $LINKS
do
  if [[ ! -L "$HOME/.$file" ]]
  then
    ln -s "${0:h}/${file:t}" $HOME/.$file
  fi
done

