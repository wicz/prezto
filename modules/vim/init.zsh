LINKS=(vimrc gvimrc)

for file in $LINKS
do
  if [[ ! -L "$HOME/.$file" ]]
  then
    ln -s "${0:h}/${file:t}" $HOME/.$file
  fi
done

alias vi="mvim -v"
alias vim="mvim -v"

