# A word before we get started...

This setup is meant to be reasonably idempotent. This means we will define a configuration that produces a single result regardless of how many times it is run. In order to this we use **nix-darwin**, which is a module for the **nix package manager**. On top of **nix-darwin**, we use **homebrew** for certain packages and **home-manager** for various services and configurations. The packages throughout the **nix** portion of the configuration are set to use the latest package from the **unstable branch**. **Homebrew** for various reasons is needed for packages unavailable or inconvenient to setup and/or manage through **nix**, such as GUI applications. **Nix** symlinks and places GUI apps to a number of non standard locations, which is less than ideal. Lastly, we use **chezmoi** to bootstrap the installation of **nix** and to handle secrets, which aren't easily managed by **nix**.

A lot of people state that flakes "are not" experimental, this is not my opinnion. Flakes are, I believe, a large part of the recent hype around nix. There are some pain points around secrets and mutable files. Currently there is no built in, official way, to maintain anything secret. People try to do things like use private repos, or copy in files from elsewhere, or use modules like agenix, but anything you copy into the nix store is **WORLD** readable. This means any user or anyone who can access a user on that computer can read any file in the nixstore. This is being tackled currently in a [proposed rfc](https://github.com/NixOS/rfcs/pull/143). Agenix does hash things, but I will wait for an official solution. You've been warned.

Chezmoi resolves some of these issues. Firstly, you can use chezmoi to template nix files, this is really powerful but I try to use it minimally as this feels like I might configure myself into a corner if used too much. Secondly, I can use chezmoi to pull text out of password managers, pull down private repos, which are not copied into the nixstore and then place files where they need to go directly. This is helpful for not only secrets, but when files need to be mutable as well. Like the `info.plist` for Alfred workflows.

While this configuration, in it's current itteration, is currently tailored to **macOS (Darwin)**, which **is fully unix compliant**, most of the configuration and software will run anywhere. The **major differences** being, primarily, **in the setup**.

---

<h1 style='color: red;'>Get Psyched!</h1>

**WARNING: If you have existing installations** of **Homebrew**, **Chezmoi**, or **Nix** it's a good idea to **backup and remove them** before continuing.

This will install Homebrew, Chezmoi, The Nix Package Manager, nix-darwin, and home-manager. There will be prompts. The installation process also requires opening a new shell, or more likely properly sourcing various things, so it will open a second Apple Terminal window to complete the installation after nix is installed.

**Bootstrap Nix**

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
- `diskutil resetUserPermissions / id -u`
  - Description: Restore known ~/ permissions


## Examples

**Fetch from Git**
Note: This also shows how to manipulate the output and use ephemeral packages in a script.

```nix
home.file."Library/Application Support/Alfred/Alfred.alfredpreferences/workflows/obsidian" = {
  enable = true;
  recursive = true;
  source = pkgs.fetchurl {
    name = "obsidian-workflow";
    url = "https://github.com/chrisgrieser/shimmering-obsidian/releases/download/3.12.8/shimmering-obsidian.alfredworkflow";
    sha256 = "sha256-ps0kdpcjnzE1cc1edkq9fKdhNweTrNgRJ1sD1atClII=";
    downloadToTemp = true;
    recursiveHash = true;
    stripRoot = false;
    postFetch = ''
      mv $downloadedFile obsidian-alfred.zip
      ${pkgs.unzip}/bin/unzip obsidian-alfred.zip -x "info.plist" -d "$out"
    '';
  };
};
```

## Aliases

- `u-nix`: Apply Chezmoi and Rebuild Darwin Flake
  - cmd: `chezmoi apply -v && darwin-rebuild switch --flake $HOME/.config/nix-darwin/.#`

# Resources

## Learning

- [Nix Cheatsheet](https://cheat.readthedocs.io/en/latest/nixos/nix_lang.html)
- [Learn X in Y](https://learnxinyminutes.com/docs/nix/)
- [Nix Pills](https://nixos.org/guides/nix-pills/)
- [Great Post On Using Chezmoi](https://pbs.bartificer.net/pbs123)
- [Official Documentation for Learning Nix](https://nix.dev/tutorials/first-steps/nix-language)

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
- [yuanw](https://github.com/yuanw/nix-home/tree/423afd8af50b3333cfad7e495b94ff913b1bb034)
- [rayandrew](https://github.com/rayandrew/nix-config)

## Misc.

- [Nerd Fonts Symbol Search](https://www.nerdfonts.com/cheat-sheet)
- [MacOS Hex Keycodes](https://gist.github.com/eegrok/949034)
- [ZSH Keybinds](https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets)
- [Builtins Documentation and Examples](https://teu5us.github.io/nix-lib.html)
- [Yabai and SKHD Configs](https://digitalblake.com/2021/08/27/yabai-and-skhd-configs/)
- [Reorder Elements in Flex Box with CSS - Firefox userChrome](https://www.geeksforgeeks.org/how-to-reorder-div-elements-using-css-only/#)

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

Nix has a great package repository, arguably one of the best. However occassionally, particularly for darwin, packages you'd expect to exist simply don't or are occassionally not up-to-date even in unstable. It's not as ubiquitous as homebrew is for mac users and just doesn't have the same level of maintainence. You can still use home-manager or nix-darwin though to configure a package.

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

## Yabai

I do not believe that yabai is being setup properly. See [this issue on github](https://github.com/LnL7/nix-darwin/issues/750). I try to work around this with `~/.config/u-nix/post/nix/yabai` which is script run after a `darwin-rebuild`. Check out `~/.local/bin/u-nix`.

## Zellij
[Zellij doesn't start](https://github.com/NixOS/nixpkgs/issues/216961)

# TODOS

- [ ] Bootstrap Digital Certificates
- [ ] ssh config clean up
- [ ] add hook to [add ssh-keys to keychain](https://apple.stackexchange.com/questions/48502/how-can-i-permanently-add-my-ssh-private-key-to-keychain-so-it-is-automatically)
- [ ] Document Extra Setup for Firefox theme https://github.com/andreasgrafen/cascade#how-to-set-it-up-1
- [ ] convert externals to directory when released https://github.com/twpayne/chezmoi/issues/3106
- [ ] cmd + k kitty skhd
- [ ] double esc to sudo command zsh
- [ ] vscode projects
- [ ] keyboard shortcuts firefox
- [ ] Create Fclone aliases
- [ ] Try to get userContent.css working, might have to stick stylus
- [ ] Request NUR firefox addons for those being used in FF but not in RYCEE repo.
- [ ] Submodules for work repos, wallpapers, etc
- [ ] stylix theming or .chezmoidata remove whats not needed
- [ ] https://github.com/NixOS/nix/issues/4423 research

## On Hold
- [-] Stacking keybindings skhd - Yabai Stacking currently broken on sonoma
- [-] While nix store is world readable, use chezmoi to directly place private files where they need to go. https://github.com/NixOS/rfcs/pull/143 - Complete but watching

# Thanks

Patrick Walsh aka PWalsh aka ZMRE. He makes a lot of great security and nix related content. His Darwin Nix youtube video has heavily inspired my configuration.
