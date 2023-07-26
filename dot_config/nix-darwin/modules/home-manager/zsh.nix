{ pkgs, ... }: {
  home = {
    # sessionPath = [ "~/.local/bin" ]; #! https://github.com/nix-community/home-manager/issues/2991
    
    sessionVariables = {
      EDITOR = "nvim";
      AUTO_NOTIFY_THRESHOLD = "20";
    };

    shellAliases = {
      dots = "(chezmoi cd; code .)";
      u-nix = ''chezmoi apply -v && git -C "$HOME/.config/nix-darwin" add -A && darwin-rebuild switch --flake "$HOME/.config/nix-darwin/.#"'';
      g-nix = "nix-collect-garbage -d && sudo nix-collect-garbage -d";
      o-nix = "nix store optimise";
      ssh = "TERM=xterm-256color ssh";
      man = "batman";
      pip = "noglob pip";
      cat = "bat";
      rm = "trash --trash-dir=$HOME/.Trash";
      rmds  = "find . -name '. DS_Store' -type f -delete";
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

    initExtra = ''
      # Completion
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

      # fzf-tab
      zstyle ':completion:*:git-checkout:*' sort false
      zstyle ':completion:*:descriptions' format '[%d]'
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --icons -a --group-directories-first --git --color=always $realpath'
      zstyle ':fzf-tab:*' switch-group ',' '.'

      # Bind Keys
      bindkey '^[[A' history-beginning-search-backward
      bindkey '^[[B' history-beginning-search-forward
      bindkey '⌥<-' backward-word
      bindkey '⌥->' forward-word
      bindkey '⌘⌫' backward-kill-line
      bindkey '⌘z' undo
      bindkey '⌘⇪z' redo
      
      # Autols
      function report() {
        DIRS=$(find . -mindepth 1 -maxdepth 1 -type d | wc -l)
        # HIDDEN_DIRS=$(find . -iname ".*" -mindepth 1 -maxdepth 1 -type d | wc -l)
        # TOTAL_DIRS=$(( $DIRS + $HIDDEN_DIRS ))
        
        FILES=$(find . -mindepth 1 -maxdepth 1 -type f | wc -l)
        # HIDDEN_FILES=$(find . -iname ".*" -mindepth 1 -maxdepth 1 -type f| wc -l)
        # TOTAL_FILES=$(( $FILES + $HIDDEN_FILES ))
        
        DIR_SIZE=$(timeout 0.5s du -sbh  . 2>/dev/null | awk '{print $1}')
        if [[ $? -ne 0 ]]; then 
            DIR_SIZE=""
        fi
        
        KEY_COLOR=$(tput bold; tput setaf 6)
        VALUE_COLOR=$(tput sitm; tput setaf 2)
        RESET_TEXT=$(tput sgr0)

        exa --icons -a --group-directories-first --git -F
        printf "\n"
        printf "''${KEY_COLOR}Path:''${RESET_TEXT}        ''${VALUE_COLOR}$(pwd)''${RESET_TEXT}\n"
        printf "''${KEY_COLOR}Folders:''${RESET_TEXT}     ''${VALUE_COLOR}''${DIRS}''${RESET_TEXT}\n"
        printf "''${KEY_COLOR}Files:''${RESET_TEXT}       ''${VALUE_COLOR}''${FILES}''${RESET_TEXT}\n"
        if [[ $DIR_SIZE != "" ]]; then 
            printf "''${KEY_COLOR}Size:''${RESET_TEXT}        ''${VALUE_COLOR}''${DIR_SIZE}''${RESET_TEXT}\n"
        fi
      }
      chpwd() {
        report
      }

      # Command-not-found hook
      HB_CNF_HANDLER="$(brew --repository)/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
      if [ -f "$HB_CNF_HANDLER" ]; then
        source "$HB_CNF_HANDLER";
      fi

    # Don't Highlight Pasted Content
    zle_highlight=(paste:none)
    '';
    
    initExtraBeforeCompInit = ''
      path+=("''$HOME/.local/bin")
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

    plugins = [
      {
        name = "fzf-tab";
        file = "fzf-tab.zsh";
        src = pkgs.fetchgit {
          url = "https://github.com/Aloxaf/fzf-tab";
          sha256 = "sha256-gvZp8P3quOtcy1Xtt1LAW1cfZ/zCtnAmnWqcwrKel6w=";
        };
      }
      {
        name = "zsh-notify";
        file = "auto-notify.plugin.zsh";
        src = pkgs.fetchgit {
          url = "https://github.com/MichaelAquilina/zsh-auto-notify";
          sha256 = "sha256-x+6UPghRB64nxuhJcBaPQ1kPhsDx3HJv0TLJT5rjZpA=";
        };
      }
      {
        name = "ssh-completion";
        file = "zsh-ssh.zsh";
        src = pkgs.fetchgit {
          url = "https://github.com/sunlei/zsh-ssh";
          sha256 = "sha256-nUVIkoF400ZdwR+uKoW8cwG0uN/+HPWQ1k8/VwA5OJQ=";
        };
      }
      {
        name = "fast-zsh-syntax";
        file = "fast-syntax-highlighting.plugin.zsh";
        src = pkgs.fetchgit {
          url = "https://github.com/zdharma-continuum/fast-syntax-highlighting";
          sha256 = "sha256-RVX9ZSzjBW3LpFs2W86lKI6vtcvDWP6EPxzeTcRZua4=";
        };
      }
      {
        name = "zsh-autopair";
        file = "autopair.zsh";
        src = pkgs.fetchgit {
          url = "https://github.com/hlissner/zsh-autopair";
          sha256 = "sha256-PXHxPxFeoYXYMOC29YQKDdMnqTO0toyA7eJTSCV6PGE=";
        };
      }
      {
        name = "zsh-autosuggestions";
        file = "zsh-autosuggestions.zsh";
        src = pkgs.fetchgit {
          url = "https://github.com/zsh-users/zsh-autosuggestions";
          sha256 = "sha256-KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
        };
      }
    ];
  };
}
