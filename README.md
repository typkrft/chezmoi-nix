# A word before we get started

This setup is meant to be reasonably idempotent. This means we will define a configuration that produces a single result regardless of how many times it is run. In order to this we use nix-darwin, which is a module for the nix package manager. On top of nix-darwin, we use homebrew for certain packages and home-manager for various services and configurations. The packages throughout the nix portion of the configuration are set to use the latest package from the `unstable` brach. Homebrew for various reasons is needed for packages unavailable or inconvenient to setup through nix, such as GUI applications. Nix symlinks and places GUI apps to a number of non standard locations, which is less than ideal. Lastly, we use chezmoi to bootstrap the installation of nix and to handle secrets, which aren't easily managed by nix. 

While this configuration, in it's current itteration, is currently tailored to macOS (Darwin), which is fully unix compliant, most of the configuration and software will run anywhere. The major differences being, primarily, in the setup.

___
<h1 style='color: red;'>Get Psyched!</h1>
{% warning %}
**NOTE:** If you have existing installations of Homebrew, Chezmoi, or Nix it's a good idea to backup and remove them before continuing.
{% endwarning %}

{% note %}
Bootstrap Nix
```shell
 zsh <(curl https://raw.githubusercontent.com/typkrft/chezmoi-nix/main/bootstrap/bootstrap.sh)
```
{% endnote %}

---
# Workflow

# Useful Commands

# TODOS
