#!/bin/bash

# Get all dotfiles to static link
DOTFILES=$(ls -1pd .?* | grep -v / | awk '{print "find `pwd` -name "$1}' | sh)

for dotfile in ${DOTFILES}; do
    # Remove the dot file if it exists; Prevents error
    DOTHOME=$HOME/$(echo $dotfile | awk -F/ '{print $NF}')
    if [ -f $DOTHOME ]; then
        rm $DOTHOME
    fi

    # Static link the dotfile in the home folder
    ln -s $dotfile $DOTHOME

    # Source the environment.
	if [[ $(uname -s) == Linux ]]
	then
		source $HOME/.bashrc
	else
		source $HOME/.bash_profile
	fi
done
