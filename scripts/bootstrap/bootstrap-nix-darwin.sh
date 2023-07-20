#!/usr/bin/env zsh
path+=('/nix/var/nix/profiles/default/bin')

(
    cd $1
    nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
    ./result/bin/darwin-installer
    darwin-rebuild switch --flake .#
)

printf '\n\n\n\n\n\n'
printf '*******************************************************************************************************'
printf '*******************************************************************************************************'
printf '***********                             BOOTSTRAP COMPLETE                                 ************'
printf '***********                   You should now close any open terminals                      ************'
printf '*******************************************************************************************************'
printf '*******************************************************************************************************'
printf '\n\n\n\n\n\n'