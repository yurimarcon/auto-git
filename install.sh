#!/bin/bash

function validate_local_dir (){

    if [ ! -d ~/.local ]; then 
        echo "Creating ~/.local"
        mkdir ~/.local
    fi

    if [ ! -d ~/.local/bin ]; then
        echo "Creating ~/.local/bin"
        mkdir ~/.local/bin
    fi

}

function install (){

    validate_local_dir 

    cat ~/.local/auto-git/auto-git.sh > ~/.local/bin/auto-git

    sudo rm -r ~/.local/auto-git

}

if [ -f ~/.local/bin/auto-git ]; then
    echo "Upgrading..."
else
    echo "Instaling..."
fi

