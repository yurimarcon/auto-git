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

    if [ ! -d ~/.local/auto-git ]; then
        echo "You do not have the source code, pleas clone the git repository."
        exit 1
    fi

}

function update_bashrc (){

    res=$(grep '"ag"=' ~/.bashrc)

    if [ -z "$res" ]; then
        echo "alias \"ag\"=\"~/.local/bin/auto-git\"" >> ~/.bashrc
    else
        echo "You alredy have a alias called 'ag', if it not is to your auto-git, please configure manualy."
    fi
    
}

function install (){

    validate_local_dir 

    cat ~/.local/auto-git/auto-git.sh > ~/.local/bin/auto-git

    chmod +x ~/.local/bin/auto-git

    update_bashrc 

    sudo rm -r ~/.local/auto-git

}

function main () {

    if [ -f ~/.local/bin/auto-git ]; then
        echo "Upgrading..."
        install
    else
        echo "Instaling..."
        install
    fi

}

main
