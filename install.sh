#!/bin/bash

LOCAL_DIR="$HOME/.local"
BIN_DIR="$LOCAL_DIR/bin"
SCRIPT_DIR="$LOCAL_DIR/auto-git"
SCRIPT_FILE="$SCRIPT_DIR/auto-git.sh"
TARGET_SCRIPT="$BIN_DIR/auto-git"
ALIAS_NAME="ag"
ALIAS_CMD="alias $ALIAS_NAME=\"$TARGET_SCRIPT\""
BASHRC="$HOME/.bashrc"

function log_message() {
    echo "$(date '+%d-%m-%Y %H:%M:%S') - $1"
}

function validate_local_dir () {
    if [ ! -d "$LOCAL_DIR" ]; then 
        log_message "Creating $LOCAL_DIR directory."
        mkdir "$LOCAL_DIR"
    fi

    if [ ! -d "$BIN_DIR" ]; then
        log_message "Creating $BIN_DIR directory."
        mkdir "$BIN_DIR"
    fi
}

function update_bashrc () {
    if ! grep -q "$ALIAS_CMD" "$BASHRC"; then
        echo "$ALIAS_CMD" >> "$BASHRC"
        log_message "Alias '$ALIAS_NAME' added to $BASHRC."
    else
        log_message "An alias named '$ALIAS_NAME' already exists. If it is not for auto-git, please configure it manually."
    fi
}

function install () {
    validate_local_dir

    if [ ! -f "$SCRIPT_FILE" ]; then
        log_message "Script $SCRIPT_FILE not found. Installation aborted."
        return 1
    fi

    cp "$SCRIPT_FILE" "$TARGET_SCRIPT"
    chmod +x "$TARGET_SCRIPT"
    log_message "Script auto-git installed in $TARGET_SCRIPT."

    update_bashrc

    rm -rf "$SCRIPT_DIR"
    log_message "Directory $SCRIPT_DIR deleted."

    log_message "Installation completed successfully!"
    log_message "***Restart the terminal to everything run corretly***"
}

function main () {
    if [ -f "$TARGET_SCRIPT" ]; then
        log_message "Upgrading auto-git..."
    else
        log_message "Installing auto-git..."
    fi
    install
}

main

