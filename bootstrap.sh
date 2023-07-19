#!/usr/bin/env bash

PATH="$PATH:$HOME/.local/bin"
$CHEZMOI_NIX_REPO='https://github.com/typkrft/chezmoi-nix.git'

declare -A CHECK_DIRS
CHECK_DIRS[CHEZMOI]=$HOME/.local/share/chezmoi
CHECK_DIRS[NIX_DARWIN]=$HOME/.config/nix-darwin
CHECK_DIRS[NIX]=/nix

printf "Checking for previous installations...\n"
for KEY in "${!CHECK_DIRS[@]}"; do
    if [ -d ${CHECK_DIRS[$KEY]} ]; then
        printf "Conflicting installation found in Directory '${CHECK_DIRS[$KEY]}.'\n\n"
        printf "Please ensure currently installations are backed up and moved.\n"
        printf "https://nixos.org/manual/nix/unstable/installation/uninstall.html\n"
        printf "https://www.chezmoi.io/user-guide/advanced/migrate-away-from-chezmoi\n"
        exit 1
    fi
done

# TODO: Look for other files related to nix home manager etc
declare -A SHELLS
SHELLS[ETC_ZSHRC]=/etc/zshrc
SHELLS[ETC_BASHRC]=/etc/bashrc
SHELLS[ETC_BASH]=/etc/bash.bashrc
SHELLS[ETC_SHELLS]=/etc/shells

printf "Looking for existing shell configs in /etc/...\n"
for KEY in "${!SHELLS[@]}"; do
    TIMESTAMP=$(date +%s%N)
    
    if [ -f "${SHELLS[$KEY]}" ]; then
        printf "Backing up '${SHELLS[$KEY]}' to '${SHELLS[$KEY]}.$TIMESTAMP.before-chezmoi-nix'\n"
        sudo -S mv "${SHELLS[$KEY]}" "${SHELLS[$KEY]}.before-chezmoi-nix"
    fi

    if [ -f "${SHELLS[$KEY]}.backup-before-nix" ]; then
        printf "Backing up '${SHELLS[$KEY]}.backup-before-nix' to '${SHELLS[$KEY]}.$TIMESTAMP.backup-before-nix'\n"
        sudo -S mv "${SHELLS[$KEY]}.backup-before-nix" "${SHELLS[$KEY]}.$TIMESTAMP.backup-before-nix"
    fi 

    if [ -f "${SHELLS[$KEY]}.backup-before-nix-darwin" ]; then
        printf "Backing up '${SHELLS[$KEY]}.backup-before-nix-darwin' to '${SHELLS[$KEY]}.$TIMESTAMP.backup-before-nix-darwin'\n"
        sudo -S mv "${SHELLS[$KEY]}.backup-before-nix-darwin" "${SHELLS[$KEY]}.$TIMESTAMP.backup-before-nix-darwin"
    fi
done

# Install Homebrew
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Nix
printf "Starting the nix installation...\n\n"
sh -c <(curl -sS -L https://nixos.org/nix/install)

# Fix because sometimes this doesn't happen
bash -c sudo -S launchctl setenv NIX_SSL_CERT_FILE "$NIX_SSL_CERT_FILE"
bash -c sudo -S launchctl kickstart -k system/org.nixos.nix-daemon
bash -c nix-shell -p nix-info --run "nix-info -m"

# Check if nix installed look for command nix


# Install Chezmoi
sh -c "$(curl -fsLS get.chezmoi.io)" -- init -b $HOME/.local/bin --apply "$CHEZMOI_NIX_REPO"

# Install darwin-nix
cd $HOME/.config/nix-darwin/
bash -c nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
bash -c ./result/bin/darwin-installer

# Install Flake
bash -c darwin-rebuild switch --flake .#



