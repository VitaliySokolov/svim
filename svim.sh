#!/bin/sh
# set -x
SVIM=~/.config/svim
export SVIM

alias svim='XDG_DATA_HOME=$SVIM/share XDG_CONFIG_HOME=$SVIM nvim'
export svim

svim $@
