#!/bin/zsh

function old() {
  SVIM=~/.config/svim
  export SVIM

  rm -rf $SVIM

  mkdir -p $SVIM/share
  # mkdir -p $SVIM/nvim

  # stow --restow --target=$SVIM/nvim .
  S_DIR=`pwd`

  pushd $SVIM
  ln -s $S_DIR nvim
  popd

  pushd ~/bin
  ln -s $S_DIR/svim.sh svim
  popd

  # alias svim='XDG_DATA_HOME=$SVIM/share XDG_CONFIG_HOME=$SVIM nvim'
  # export svim
}

main ()
{

  local RC_FILE="$HOME/.zshrc"
  if [ -f "$HOME/.commonrc" ] ; then
    RC_FILE="$HOME/.commonrc"
  fi

  if ! command -v vs 2>&1 >/dev/null ; then
    echo "Adding vs alias to $RC_FILE..."
    echo "alias vs='NVIM_APPNAME=nvim-svim nvim' # svim" >> $RC_FILE
    
    local CONFIG_PATH="$HOME/.config"
    local CONFIG_NAME="nvim-svim"
    local SVIM_DIR=`pwd`
    echo "Linking config..."
    pushd $CONFIG_PATH
    ln -s $SVIM_DIR $CONFIG_NAME
    popd
    echo "Linking done."

    echo "You can add next script t $RC_FILE"
    echo "vv() {"
    echo "  select config in lazyvim kickstart nvchad astrovim lunarvim svim"
    echo "  do NVIM_APPNAME=nvim-$config nvim $@; break; done"
    echo "}"
  fi
}

# main
test() {
  command -v vs 
  if ! command -v vs 2>&1 >/dev/null ; then
    echo "no"
  else
    echo "yes"
  fi
}

test
