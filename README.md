# A word before we get started...

This setup is meant to be reasonably idempotent. This means we will define a configuration that produces a single result regardless of how many times it is run. In order to this we use **nix-darwin**, which is a module for the **nix package manager**. On top of **nix-darwin**, we use **homebrew** for certain packages and **home-manager** for various services and configurations. The packages throughout the **nix** portion of the configuration are set to use the latest package from the **unstable branch**. **Homebrew** for various reasons is needed for packages unavailable or inconvenient to setup and/or manage through **nix**, such as GUI applications. **Nix** symlinks and places GUI apps to a number of non standard locations, which is less than ideal. Lastly, we use **chezmoi** to bootstrap the installation of **nix** and to handle secrets, which aren't easily managed by **nix**. 

While this configuration, in it's current itteration, is currently tailored to **macOS (Darwin)**, which **is fully unix compliant**, most of the configuration and software will run anywhere. The **major differences** being, primarily, **in the setup**.

___

<h1 style='color: red;'>Get Psyched!</h1>

**WARNING: If you have existing installations** of **Homebrew**, **Chezmoi**, or **Nix** it's a good idea to **backup and remove them** before continuing.

**Bootstrap Nix**
```shell
zsh <(curl https://raw.githubusercontent.com/typkrft/chezmoi-nix/main/bootstrap/bootstrap.sh)
```

---
# Workflow

# Useful Commands
- `nix --extra-experimental-features nix-command store optimise`
    - Description: ...
- `nix-collect-garbage -d` && `sudo nix-collect-garbage -d`
    - Description: ...

# Resources
## Learning
- [Nix Cheatsheet](https://cheat.readthedocs.io/en/latest/nixos/nix_lang.html)
- [Learn X in Y](https://learnxinyminutes.com/docs/nix/)
- [Nix Pills](https://nixos.org/guides/nix-pills/)

## Documentation
- [Nix Reference Manual](https://nixos.org/manual/nix/unstable/)
- [Chezmoi](https://www.chezmoi.io/)

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
- [jtojnar](https://github.com/jtojnar/nixfiles/tree/3cfa96d86c2f8241ad693ba4daa45c56b17c4446)

# TODOS
