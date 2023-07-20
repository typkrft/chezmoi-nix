#!/usr/bin/env zsh

timestamp=$(date +%s%N)
sudo -S mv $files[etc_bashrc] $files[etc_bashrc].before-nix-darwin.$timestamp
sudo -S mv $files[etc_zshrc] $files[etc_zshrc].before-nix-darwin.$timestamp

nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer -o "$HOME/.config/nix-darwin/nix-darwin-result"
"$HOME/.config/nix-darwin/nix-darwin-result/bin/darwin-installer"
darwin-rebuild switch --flake "$HOME/.config/nix-darwin/.#"

printf '\n\n\n\n\n\n'
printf '*******************************************************************************************************'
printf '*******************************************************************************************************'
printf '***********                             BOOTSTRAP COMPLETE                                 ************'
printf '***********                   You should now close any open terminals                      ************'
printf '*******************************************************************************************************'
printf '*******************************************************************************************************'
printf '\n\n\n\n\n\n'