{ pkgs, ... }: {
  home = {
    sessionPath = [ "~/.local/bin" ];
    
    sessionVariables = {
      EDITOR = "nvim";
    };

    shellAliases = {
      dots = "chezmoi cd; code .";
      u-nix = "chezmoi apply -v && darwin-rebuild switch --flake $HOME/.config/nix-darwin/.#";
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    autocd = true;

    sessionVariables = {
      EXA_ICON_SPACING = 2;
      AUTO_NOTIFY_THRESHOLD = 20;
    };

    initExtraFirst = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
      eval "$(zoxide init zsh)"
      source $(brew --prefix asdf)/libexec/asdf.sh
    '';
    
    initExtraBeforeCompInit = ''
      FPATH="$(brew --prefix)/share/zsh/site-functions:''${FPATH}"
    '';

    history = {
      expireDuplicatesFirst = true;
      extended = true;
      ignoreDups = true;
      ignoreSpace = true;
      save = 100000;
      size = 100000;
      share = true;
    };

    historySubstringSearch = {
      enable = true;
    };

  };
}