#!/usr/bin/env zsh

configs=(/etc/zshrc /etc/bashrc /etc/bash.bashrc /etc/shells)
for config in $configs; do 
    timestamp=$(date +%s%N)    
    if [ -f $config ]; then
        printf "Moving %s to %s.\n" "$config" "$config.before-nix-darwin.$timestamp"
        sudo -S mv "$config" "$config.before-nix-darwin.$timestamp"
    fi
done

printf "Bootstraping Nix Darwin and installing Flake.\n"
nix --extra-experimental-features 'nix-command flakes' run nix-darwin -- switch --flake "$HOME/.config/nix-darwin/.#"

for file in "$HOME"/.local/share/chezmoi/bootstrap/run/*; do
    printf "Running %s" "$file"
    chmod +x "$file"
    $file
done

printf "Installation Complete"