#!/usr/bin/env zsh
path+=('/nix/var/nix/profiles/default/bin')

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