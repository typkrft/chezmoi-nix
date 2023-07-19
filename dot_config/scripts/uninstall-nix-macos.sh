#!/usr/bin/env zsh

backup_etc_configs() {
    for file in "$files"; do
        timestamp=$(date +%s%N)
        if [ -f "$file" ]; then
            echo "Moving $file to $file.before-chezmoi-nix-uninstall.$timestamp"
            sudo -S mv "$file" "$file.before-chezmoi-nix-uninstall.$timestamp"
        fi
    done
}


rm_daemons() {
    echo "Removing Launch Daemons and Services"
    sudo -S launchctl unload /Library/LaunchDaemons/org.nixos.nix-daemon.plist
    sudo -S rm /Library/LaunchDaemons/org.nixos.nix-daemon.plist
    sudo -S launchctl unload /Library/LaunchDaemons/org.nixos.darwin-store.plist
    sudo -S rm /Library/LaunchDaemons/org.nixos.darwin-store.plist
}


rm_groups_users() {
    echo "Removing group 'nixbld'"
    sudo dscl . -delete /Groups/nixbld
    for u in $(sudo dscl . -list /Users | grep _nixbld); do 
        echo "Removing /Users/$u"
        sudo dscl . -delete /Users/$u
    done
}


edit_fstab() {
    timestamp=$(date +%s%N)
    echo "Backing up /etc/fstab to /etc/fstab.before-chezmoi-nix-uninstall.$timestamp"
    sudo -S cp /etc/fstab /etc/fstab.before-chezmoi-nix-uninstall.$timestamp
    echo "Removing '\nix' partition from '/etc/fstab'"
    sudo -S sed -i '' -e '/\/nix/d' /etc/fstab
}


edit_synthetic() {
    timestamp=$(date +%s%N)
    echo "Backing up '/etc/synthetic.conf' to '/etc/synthetic.conf.before-chezmoi-nix-uninstall.$timestamp'"
    sudo -S cp /etc/synthetic.conf /etc/synthetic.conf.before-chezmoi-nix-uninstall.$timestamp
    sudo -S sed -i '' -e '/nix/d' /etc/synthetic.conf
}


rm_system_files() {
    nix_system_files=(
        '/etc/nix'
        '/var/root/.nix-profile'
        '/var/root/.nix-defexpr'
        '/var/root/.nix-channels' 
        "$HOME/.nix-profile"
        "$HOME/.nix-defexpr"
        "$HOME/.nix-channels"
    )

    for file in "$nix_system_files"; do 
        echo "Removing '$file'"
        sudo -S rm -rf "$file"
    done
}


rm_partition() {
    echo "Removing the '/nix' partition"
    sudo -S diskutil apfs deleteVolume /nix
}


main() {
    if [[ -z "$(ls -A /nix)" ]]; then
        echo "\n\nPartion '/nix' does not exist or is empty. Exiting.\n" 
        exit 1
    fi
    
    declare -A files
    files=(
        [etc_zshrc]='/etc/zshrc'
        [etc_bashrc]='/etc/bashrc'
        [etc_bash]='/etc/bash.bashrc'
        [etc_shells]='/etc/shells'
    )

    backup_etc_configs
    rm_daemons
    rm_groups_users
    edit_fstab
    edit_synthetic
    rm_system_files
    rm_partition

    echo "Nix has been uninstalled. Partition " '\nix' " will appear until you reboot."

}

main