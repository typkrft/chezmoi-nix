#!/usr/bin/env zsh

check_previous_installs() {
    echo "Checking for previous installations...\n"
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
            echo "Moving '$file' to '$file.before-chezmoi-nix.$timestamp'\n"
            sudo -S mv "$file" "$file.before-chezmoi-nix.$timestamp"
        fi

        if [ -f "$file.backup-before-nix" ]; then
            echo "Moving '$file.backup-before-nix' to '$file.before-chezmoi-nix.$timestamp'\n"            
            sudo -S mv "$file.backup-before-nix" "$file.before-chezmoi-nix.$timestamp"
        fi

        if [ -f "$file.before-nix" ]; then 
            echo "Moving '$file.before-nix' to '$file.before-chezmoi-nix.$timestamp'\n"            
            sudo -S mv "$file.before-nix" "$file.before-chezmoi-nix.$timestamp"
        fi

        if [ -f "$file.backup-before-nix-darwin" ]; then
            echo "Moving '$file.backup-before-nix-darwin' to '$file.before-chezmoi-nix.$timestamp'\n"            
            sudo -S mv "$file.backup-before-nix-darwin" "$file.before-chezmoi-nix.$timestamp"
        fi

        echo "Creating $file\n"
        sudo -S >$file

    done
}


install_homebrew() {
    echo "\n\nInstalling Homebrew\n"
    bash -ci "$(curl -fLsS $urls[homebrew])"
    
    if [ $? -eq 0 ]; then
        echo "Homebrew was installed Successfully."
    else
        echo "Installation of Homebrew failed. Exiting."
        exit 1
    fi
}


install_nix() {
    echo "\n\nInstalling Nix\n"
    bash -ci "$(curl -fLsS $urls[nix])"
    
    if [ $? -ne 0 ]; then
        echo "\n\nInstallation of Nix failed. Exiting\n"
        exit 1
    fi

    echo "\n\nPost Installation Setup of Nix\n"
    path+=('/nix/var/nix/profiles/default/bin')
    NIX_SSL_CERT_FILE='/nix/var/nix/profiles/default/etc/ssl/certs/ca-bundle.crt'

    sudo -S launchctl setenv NIX_SSL_CERT_FILE "$NIX_SSL_CERT_FILE"
    sudo -S launchctl kickstart -k system/org.nixos.nix-daemon
    nix-shell -p nix-info --run "nix-info -m"

    if [ $? -ne 0 ]; then
        echo "\n\nPost Installation of Nix failed. Exiting\n"
        exit 1
    fi

    echo "\n\nNix was installed Successfully\n"
}


install_chezmoi() {
    echo "\n\nInstalling Chezmoi\n"
    echo "$urls[chezmoi]"
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
    echo "\n\nInstalling Nix-Darwin\n"
       
    (
        cd "$dirs[nix_darwin]" 
        git init
        git add -A
    )
    if [ $? -ne 0 ]; then
        echo "\n\nInstallation of Nix-Darwin failed. Exiting\n"
        exit 1
    fi

    
    (
        path+=('/nix/var/nix/profiles/default/bin')
        # NIX_SSL_CERT_FILE='/nix/var/nix/profiles/default/etc/ssl/certs/ca-bundle.crt'
        # sudo -S launchctl setenv NIX_SSL_CERT_FILE "$NIX_SSL_CERT_FILE"
        # sudo -S launchctl kickstart -k system/org.nixos.nix-daemon

        cd "$dirs[nix_darwin]" 
        nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
        ./result/bin/darwin-installer
    )
    if [ $? -ne 0 ]; then
        echo "\n\nInstallation of Nix-Darwin failed. Exiting\n"
        exit 1
    fi
    
    echo "\n\nNix-Darwin Installed Successfully\n"
}


install_flake() {
    echo "\n\nInstalling Nix-Darwin Flake\n"
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

    echo "\n\nBootstrap Complete\n"
}


main