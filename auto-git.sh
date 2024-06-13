#!/bin/bash

function exit_exception (){
    if [ $? -eq 130 ]; then
        echo "Exiting..."
        exit 1
    fi   
}

function switch_branch (){
    
    selected=$(git branch | fzf +m \
        --header "Select the branch to go:" \
        --height 40% \
        --layout reverse \
        --border\
        --preview \
            'git -c color.ui=always log --oneline $(echo {} | tr -d "* ")' \
        --color bg:#222222,preview-bg:#333333)
    
    exit_exception 
    
    selected=$(echo $selected | tr -d "* ")
    
    git switch "$selected"
}

function merge (){

    selected=$(git branch | fzf +m \
        --header "Select the branch to merge:" \
        --height 100% \
        --layout reverse \
        --border\
        --preview \
            'git -c color.ui=always diff $(git branch | grep "^*" | tr -d "* " ) $(echo {} | tr -d "* ")' \
        --color bg:#222222,preview-bg:#333333)
    
    exit_exception 
    
    selected=$(echo $selected | tr -d "* ")
    
    git merge "$selected"
}

function delete_branch (){
    
    selected=$(git branch | fzf +m \
        --header "select the branch to delete:" \
        --height 40% \
        --layout reverse \
        --border\
        --preview \
            'git -c color.ui=always log --oneline $(echo {} | tr -d "* ")' \
        --color bg:#222222,preview-bg:#333333)
    
    exit_exception 
    
    selected=$(echo $selected | tr -d "* ")
    
    git branch -d "$selected"
}

function main (){
    
    options=(\
        "1 - Switch branch" \
        "2 - Git merge" \
        "3 - Delete branch" \
        "Exit"\
        )

    selected=$( for opt in "${options[@]}" ; do echo $opt ; done | fzf +m \
        --header "Select one option:" \
        --height 40% \
        --layout reverse \
        --border\
        --color bg:#222222)

    exit_exception
    
    case "$selected" in
        ${options[0]})
            echo "$selected"
            switch_branch
            exit 0
        ;;
        ${options[1]})
            echo "$selected"
            merge
            exit 0
        ;;
        ${options[2]})
            echo "$selected"
            delete_branch
            exit 0
        ;;
        ${options[3]})
            echo "$selected"
            exit 0
        ;;
        *)
        exit 0
    esac
}

main
