#!/usr/bin/env zsh

install_chezmoi() {
    if  command -v chezmoi &> /dev/null; then
        printf "Chezmoi is already installed. Skipping....\n"
        return 0
    fi

    if ! bash -ci "$(curl -fLsS  get.chezmoi.io)" -- -b "$HOME"/.local/bin; then
        printf "Chezmoi failed to install. Exiting...\n"
        exit 1
    fi
}


install_homebrew() {
    if command -v brew &> /dev/null; then
        printf "Homebrew is already installed. Skipping....\n"
        return 0
    fi

    if ! bash -ci "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
        printf "Homebrew failed to install. Exiting...\n"
        exit 1
    fi
}


install_nix() {
    if [ -d /nix ]; then 
        printf "Nix is already installed. Skipping....\n"
        return 0
    fi

    configs=(/etc/zshrc /etc/bashrc /etc/bash.bashrc /etc/shells)
    for config in $configs; do 

        timestamp=$(date +%s%N)    
        if [ -f $config ]; then
            printf "Moving %s to %s.\n" "$config" "$config.before-nix.$timestamp"
            sudo -S mv "$config" "$config.before-nix.$timestamp"
        fi
        
        printf "Creating new empty %s.\n" "$config"
        sudo -S touch "$config"
    done

    if ! bash -ci "$(curl -fLsS  https://nixos.org/nix/install)"; then 
        printf "Nix failed to install. Exiting...\n"
        exit 1
    fi

    NIX_SSL_CERT_FILE='/nix/var/nix/profiles/default/etc/ssl/certs/ca-bundle.crt'

    printf "Starting Nix Daemon\n"
    sudo -S launchctl setenv NIX_SSL_CERT_FILE "$NIX_SSL_CERT_FILE"
    sudo -S launchctl kickstart -k system/org.nixos.nix-daemon

    printf "Making sure Nix installed and Active\n"
    if ! nix-shell -p nix-info --run 'nix-info -m'; then
        printf "Nix failed to install. Exiting...\n"
        exit 1
    fi
}


setup_repos() {
    if [ -d "$HOME"/.local/share/chezmoi ]; then
        printf "Chezmoi source already exists. Exiting...\n"
        exit 1
    fi

    if [ -d "$HOME"/.config/nix-darwin ]; then
        printf "Nix-Darwin repo already exists. Exiting...\n"
        exit 1
    fi

    chezmoi init "$1"
    chezmoi apply -v
}


bootstrap_nix_darwin(){
    printf "This installation will continue in a new terminal window.\n"

    chmod +x "$HOME"/.local/share/chezmoi/bootstrap/bootstrap-nix-darwin.sh
    open -a Terminal.app -n "$HOME/.local/share/chezmoi/bootstrap-nix-darwin.sh"
}


main() {
    install_chezmoi
    install_homebrew
    install_nix

    read 'user_repo?Enter the address for you chezmoi-nix repo: '
    setup_repos "$user_repo"

    bootstrap_nix_darwin
}

export PATH=/bin:/usr/bin:/opt/homebrew/bin:$HOME/.local/bin:/nix/var/nix/profiles/default/bin

set -e 
main
