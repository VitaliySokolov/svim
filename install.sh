#!/bin/bash

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
