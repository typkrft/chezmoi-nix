# A word before we get started...

This setup is meant to be reasonably idempotent. This means we will define a configuration that produces a single result regardless of how many times it is run. In order to this we use **nix-darwin**, which is a module for the **nix package manager**. On top of **nix-darwin**, we use **homebrew** for certain packages and **home-manager** for various services and configurations. The packages throughout the **nix** portion of the configuration are set to use the latest package from the **unstable branch**. **Homebrew** for various reasons is needed for packages unavailable or inconvenient to setup and/or manage through **nix**, such as GUI applications. **Nix** symlinks and places GUI apps to a number of non standard locations, which is less than ideal. Lastly, we use **chezmoi** to bootstrap the installation of **nix** and to handle secrets, which aren't easily managed by **nix**. 

While this configuration, in it's current itteration, is currently tailored to **macOS (Darwin)**, which **is fully unix compliant**, most of the configuration and software will run anywhere. The **major differences** being, primarily, **in the setup**.

___

<h1 style='color: red;'>Get Psyched!</h1>

**WARNING: If you have existing installations** of **Homebrew**, **Chezmoi**, or **Nix** it's a good idea to **backup and remove them** before continuing.

**Bootstrap Nix**
This will install Homebrew, Chezmoi, The Nix Package Manager, nix-darwin, and home-manager. There will be prompts. The installation process also requires opening a new shell, or more likely properly sourcing various things, so it will open a second Apple Terminal window to complete the installation after nix is installed. 
```shell
zsh <(curl https://raw.githubusercontent.com/typkrft/chezmoi-nix/main/bootstrap/bootstrap.sh)
```

---
# Workflow


# Important Paths
- `~/.config`
- `~/.config/nix-darwin/`
- `~/.local/share/chezmoi`
- `~/.local/state/home-manager`
- `~/.local/state/nix`
- `~/.nixpkgs/darwin-configuration.nix`
- `/nix`
- `/etc/nix/`
- `/etc/bashrc`
- `/etc/bash.bashrc`
- `/etc/profiles`
- `/etc/shells`
- `/etc/zshrc`
- `/opt/homebrew`


# Useful Commands
- `nix --extra-experimental-features nix-command store optimise`
    - Description: ...
- `nix-collect-garbage -d` && `sudo nix-collect-garbage -d`
    - Description: ...
- `darwin-rebuild switch --flake $HOME/.config/nix-darwin/.#`
    - Userful Flags:
        - --show-trace

## Aliases
- `u-nix`: Apply Chezmoi and Rebuild Darwin Flake
    - cmd: `chezmoi apply -v && darwin-rebuild switch --flake $HOME/.config/nix-darwin/.#`

# Resources
## Learning
- [Nix Cheatsheet](https://cheat.readthedocs.io/en/latest/nixos/nix_lang.html)
- [Learn X in Y](https://learnxinyminutes.com/docs/nix/)
- [Nix Pills](https://nixos.org/guides/nix-pills/)

## Documentation
- [Nix Reference Manual](https://nixos.org/manual/nix/unstable/)
- [Chezmoi](https://www.chezmoi.io/)
- [Flake Schema](https://nixos.wiki/wiki/Flakes#Flake_schema)

## Packages
- [Brew Packages](https://formulae.brew.sh)
- [Nix Packages](https://search.nixos.org/packages)

## Nix Options
- [Nix-Darwin Opts](https://daiderd.com/nix-darwin/manual/index.html)
- [Home-Manager Opts](https://nix-community.github.io/home-manager/options.html)

## Posts

## Videos

## Repos
- [Nix-Darwin](https://github.com/LnL7/nix-darwin/)

## Other Dots
- [ZMRE](https://github.com/zmre/nix-config/tree/main)
- [ZMRE Simple](https://github.com/zmre/mac-nix-simple-example)
- [jtojnar](https://github.com/jtojnar/nixfiles/tree/3cfa96d86c2f8241ad693ba4daa45c56b17c4446)


# Issues
## But first, a rant. 

There be dragons here and your sword is drenched in poison. Make sure you don't drop it on your foot. For all of Nix's power and usefulness is a double-edge sword. Nix is a nightmare to troubleshoot and debug. It's language is terse with poorly described lambdas abound. Errors messages are cryptic. And navigating even to the path of a particular file to research something can be a chore. A single problem with a module, flake, derivation, etc can bork your entire configuration. That's just part of the territory when you are building software with this level of reproducibility. Let's just say there are reasons that companies are starting to pick up nix and there are also a reasons those companies are paying the people that manage it, often, more than their own developers.

**Example: Trace Output**
```nix
… while calling anonymous lambda

         at /nix/store/lc0799mf25zgdbg9ylcflc5h8ngz6wia-source/lib/modules.nix:783:28:

          782|         # Process mkMerge and mkIf properties.
          783|         defs' = concatMap (m:
             |                            ^
          784|           map (value: { inherit (m) file; inherit value; }) (builtins.addErrorContext "while evaluating definitions from `${m.file}':" (dischargeProperties m.value))

       … while evaluating definitions from `<unknown-file>':

       … from call site

         at /nix/store/lc0799mf25zgdbg9ylcflc5h8ngz6wia-source/lib/modules.nix:784:137:

          783|         defs' = concatMap (m:
          784|           map (value: { inherit (m) file; inherit value; }) (builtins.addErrorContext "while evaluating definitions from `${m.file}':" (dischargeProperties m.value))
             |                                                                                                                                         ^
          785|         ) defs;

       … while calling 'dischargeProperties'
```

How in the fuck do you evaluate definitions in an `<unknown-file>`? This is just an excerpt from a problem I had. Nix worked, and without even changing my configuration stopped working when I went to rebuild my config to update brew packages. The "solution" was to delete my `flake.lock` so it would redownload my flake inputs. No idea what was resolved, why it was resolved, etc. Cool...cool.

- Nix has a greate package repository, arguably one of the best. However occassionally, particularly for darwin, packages you'd expect to exist simply don't or are occassionally not up-to-date even in unstable. It's not as ubiquitous as homebrew is for mac users and just doesn't have the same level of maintainence. You can still use home-manager or nix-darwin though to configure a package. 
    1. Add the package to home brew. 
    2. In the nix-darwin or home-manager for the config for the package, there is usually an option to specify a package. Set the package to a blank output like so: `pkgs.runCommand "firefox-0.0.0" { } "mkdir $out";`.

    Here is part of a flake I use for Firefox. 
    ```nix
    { pkgs, themes, ... }: {
        programs.firefox.enable = true;
        # NOTE: Use a dummy package, Firefox is managed by homebrew
        programs.firefox.package = pkgs.runCommand "firefox-0.0.0" { } "mkdir $out";
        programs.firefox.profiles."ff-nix" = {
            name = "ff-nix";
            isDefault = true;
            id = 0;
        # ...
        };
    }
            
    ```

# TODOS


# Thanks
Patrick Walsh aka PWalsh aka ZMRE. He makes a lot of great security and nix related content. His Darwin Nix youtube video has heavily inspired my configuration. 