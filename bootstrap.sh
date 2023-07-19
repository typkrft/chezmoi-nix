#!/usr/bin/env zsh

check_previous_installs() {
    echo "Checking for previous installations..."
    for directory in $1; do
        if [ -d $directory ]; then
            echo "Conflicting installation found: '$directory'.\n\n"
            echo "Please ensure you backup and uninstall your previous installations first."
            echo "https://nixos.org/manual/nix/unstable/installation/uninstall.html"
            echo "https://www.chezmoi.io/user-guide/advanced/migrate-away-from-chezmoi"
            exit 1
        fi
    done
}


backup_create_configs() {
    for file in "${(v)files[@]}"; do
        timestamp=$(date +%s%N)

        if [ -f "$file" ]; then
            sudo -S mv "$file" "$file.before-chezmoi-nix.$timestamp"
        fi

        if [ -f "$file.backup-before-nix" ]; then
            sudo -S mv "$file.backup-before-nix" "$file.before-chezmoi-nix.$timestamp"
        fi

        if [ -f "$file.before-nix" ]; then 
            sudo -S mv "$file.before-nix" "$file.before-chezmoi-nix.$timestamp"
        fi

        if [ -f "$file.backup-before-nix-darwin" ]; then
            sudo -S mv "$file.backup-before-nix-darwin" "$file.before-chezmoi-nix.$timestamp"
        fi

        sudo -S >$file

    done
}


install_homebrew() {
    echo "Attempting to install Homebrew..."
    bash -ci "$(curl -fLsS $urls[homebrew])"
    
    if [ $? -eq 0 ]; then
        echo "Homebrew was installed Successfully."
    else
        echo "Installation of Homebrew failed. Exiting."
        exit 1
    fi
}


install_nix() {
    echo "Attempting to install Nix..."
    bash -ci "$(curl -fLsS $urls[nix])"
    
    if [ $? -ne 0 ]; then
        echo "Installation of Nix failed. Exiting."
        exit 1
    fi

    echo "Post Installation Setup of Nix"
    path+=('/nix/var/nix/profiles/default/bin')
    NIX_SSL_CERT_FILE='/nix/var/nix/profiles/default/etc/ssl/certs/ca-bundle.crt'

    sudo -S launchctl setenv NIX_SSL_CERT_FILE "$NIX_SSL_CERT_FILE"
    sudo -S launchctl kickstart -k system/org.nixos.nix-daemon
    nix-shell -p nix-info --run "nix-info -m"

    if [ $? -ne 0 ]; then
        echo "Post Installation of Nix failed. Exiting."
        exit 1
    fi

    echo "Nix was installed Successfully."
}


install_chezmoi() {
    echo "Attempting to install Chezmoi..."
    bash -ci "$(curl -fLsS $urls[chezmoi])" -- -b $HOME/.local/bin
    
    if [ $? -ne 0 ]; then
        echo "Installation of Chezmoi failed. Exiting."
        exit 1
    fi

    echo "Post Installation setup for Chezmoi"
    path+=("$HOME/.local/bin")
    chezmoi init "$urls[dots]"
    chezmoi apply -v

    echo "Chezmoi was installed Successfully."
}


install_nix_darwin() {
    echo "Installing Nix-Darwin"
    cd "$dirs[nix-darwin]"
    
    git init
    git add -A
    
    nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
    ./result/bin/darwin-installer
    echo "Nix-Darwin Installed Successfully"
}


install_flake() {
    nix-darwin -- switch --flake "$dirs[nix_darwin]/.#"
}


main () {
    declare -A urls
    declare -A files
    declare -A dirs

    urls=(
        [dots]='https://github.com/typkrft/chezmoi-nix'
        [homebrew]='https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh'
        [nix]='https://nixos.org/nix/install'
        [chezmoi]='https://get.chezmoi.io'
    )

    files=(
        [etc_zshrc]='/etc/zshrc'
        [etc_bashrc]='/etc/bashrc'
        [etc_bash]='/etc/bash.bashrc'
        [etc_shells]='/etc/shells'
    )

    dirs=(
        [chezmoi_source]="$HOME/.local/share/chezmoi"
        [chezmoi_bin]="$HOME/.local/bin"
        [nix_store]="/nix"
        [nix_darwin]="$HOME/.config/nix-darwin"
    )

    install_dirs=( "$dirs[chezmoi_source]" "$dirs[nix_store]" "$dirs[nix_darwin]" )
    check_previous_installs "$install_dirs"
    backup_create_configs "$files"
    install_homebrew
    install_chezmoi
    install_nix
    install_nix_darwin
    install_flake
}


main