#!/usr/bin/env zsh

# The new terminal must source the shell config nix created, and then it needs to be removed for nix-darwin
timestamp=$(date +%s%N)
sudo -S mv /etc/bashrc "/etc/bashrc.before-nix-darwin.$timestamp"
sudo -S mv /etc/zshrc "/etc/zshrc.before-nix-darwin.$timestamp"
sudo -S mv /etc/shells "/etc/shells.before-nix-darwin.$timestamp"

# Book Strap Flake
nix --extra-experimental-features 'nix-command flakes' run nix-darwin -- switch --flake "$HOME/.config/nix-darwin/.#"

if [[ ! -z "$(\ls -A $HOME/.local/share/chezmoi/bootstrap/run)" ]]; then
    echo "Running Post Nix-Darwin Configurations"

    for file in "$HOME/.local/share/chezmoi/bootstrap/run/**/*(.)"; do 
        echo "Running $file"
        zsh $file
    done
fi

cat <<EOF


*******************************************************************************************************
*******************************************************************************************************
**                                                                                                   **
**                                      BOOTSTRAP COMPLETE                                           **
**                                You can close your terminal now                                    **
**                                                                                                   **
*******************************************************************************************************
*******************************************************************************************************


EOF
