{ pkgs, ... }: {
  home.stateVersion = "23.11";
  
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    flags = [ "--disable-up-arrow" ];
  }; 

  programs.bat = with pkgs; {
    enable = true;
    extraPackages = with bat-extras; [ batdiff batman batgrep batwatch ];
    
    themes = {
      dracula = builtins.readFile (fetchFromGitHub
        {
          owner = "dracula";
          repo = "sublime"; # Bat uses sublime syntax for its themes
          rev = "26c57ec282abcaa76e57e055f38432bd827ac34e";
          sha256 = "019hfl4zbn4vm4154hh3bwk6hm7bdxbr1hdww83nabxwjn99ndhv";
        } + "/Dracula.tmTheme");
    };
    
    config = {
      italic-text = "always";
    };
  };

  programs.starship = {
    # todo settings
    enable = true;
    enableZshIntegration = true;
  }; 

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    colors = {
      "fg" = "#f8f8f2"; 
      "fg+" = "#f8f8f2";
      "bg" = "#282a36"; 
      "bg+" = "#44475a";
      "hl" = "#bd93f9"; 
      "hl+" = "#bd93f9";
      "info" = "#ffb86c";
      "prompt" = "#50fa7b";
      "pointer" = "#ff79c6";
      "marker" = "#ff79c6";
      "spinner" = "#ffb86c";
      "header" = "#6272a4";
    };
    tmux.enableShellIntegration = true;
  };

  programs.git = {
    enable = true;
    ignores = [ ".DS_Store" ];
    userEmail = "12100960+typkrft@users.noreply.github.com";
    userName = "typkrft";
  };

  programs.gh = {
    enable = true;
    extensions = with pkgs; [ gh-eco gh-dash ];
  };

  programs.exa = {
    enable = true;
    enableAliases = true;
    git = true;
    icons = true;
    extraOptions = [
      "-a" 
      "-F" 
      "--group-directories-first"
      "-G"
    ];
  };

  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    
    settings = {
      # simplified_ui = flase;
      pane_frames = false;
      theme = "dracula";
      ui.pane_frame.rounded_corners = false;

      #! https://github.com/nix-community/home-manager/issues/4054
      # NOTE: Alternative link to file eg: home.file.".config/zellij/config.kdl".source = ./config.kdl;
      # keybinds = {
      #   normal = {
      #     bind = [
      #       {
      #         _args = [ "Ctrl k = Clear;" ];
      #       }
      #     ];
      #   };
      # };
    };
    
  };

}