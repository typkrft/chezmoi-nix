#!/usr/bin/env zsh


if [[ ! -d "$HOME"/code/private ]]; then 
    echo "$HOME/code/private does not exist."
    exit 1
fi 

# SSH
rsync -av ~/code/private/ssh/ ~/.ssh/
chmod -R u=rx,g=,o= ~/.ssh/public
chmod -R u=rx,g=,o= ~/.ssh/private
chmod -R u=rwx,g=,o= ~/.ssh/known_hosts

# Navi


# Alfred
if [[ -d "$HOME"/Library/"Application Support"/Alfred/Alfred.alfredpreferences/workflows/bitwarden ]]; then
    rsync -av "$HOME"/code/private/alfred/bitwarden.plist "$HOME"/Library/"Application Support"/Alfred/Alfred.alfredpreferences/workflows/bitwarden/info.plist
fi

if [[ -d "$HOME"/Library/"Application Support"/Alfred/Alfred.alfredpreferences/workflows/menubar ]]; then
    rsync -av "$HOME"/code/private/alfred/menubar.plist "$HOME"/Library/"Application Support"/Alfred/Alfred.alfredpreferences/workflows/menubar/info.plist
fi

if [[ -d "$HOME"/Library/"Application Support"/Alfred/Alfred.alfredpreferences/workflows/paste-plaintext ]]; then
    rsync -av "$HOME"/code/private/alfred/paste-plaintext.plist "$HOME"/Library/"Application Support"/Alfred/Alfred.alfredpreferences/workflows/paste-plaintext/info.plist
fi

if [[ -d "$HOME"/Library/"Application Support"/Alfred/Alfred.alfredpreferences/workflows/recorder ]]; then
    rsync -av "$HOME"/code/private/alfred/recorder.plist "$HOME"/Library/"Application Support"/Alfred/Alfred.alfredpreferences/workflows/recorder/info.plist
fi

if [[ -d "$HOME"/Library/"Application Support"/Alfred/Alfred.alfredpreferences/workflows/obsidian ]]; then
    rsync -av "$HOME"/code/private/alfred/obsidian.plist "$HOME"/Library/"Application Support"/Alfred/Alfred.alfredpreferences/workflows/obsidian/info.plist
fi