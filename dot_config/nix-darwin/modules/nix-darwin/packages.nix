{ pkgs, nix-vars, ... }: {
  # System Wide
  environment.systemPackages = with pkgs; [
    coreutils
    curl
    fd 
    gnused
    neovim
    ripgrep
  ];

  # User
  users.users."${nix-vars.username}".packages = with pkgs; [
    bitwarden-cli
    jq
    pueue
    notify
    rnix-lsp
    nixpkgs-fmt
    zoxide
    trash-cli
    tealdeer
    fclones
  ];

  # Homebrew
  homebrew = {
    enable = true;
    
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
    
    global = {
      autoUpdate = true;
      brewfile = true;
    };
    
    taps = [
      "homebrew/services"
      "homebrew/cask-versions"
      "FelixKratz/formulae"
      "homebrew/command-not-found"
    ];

    masApps = {
      Spark = 1176895641;
      Bitwarden = 1352778147;
      "PDF Expert" = 1055273043;
    };

    # NOTE: Casks are prefered because of weird placement of GUI Apps by Nix / Nix Darwin
    casks = [
      "alfred"
      "authy"
      "betterdiscord-installer"
      "caffeine"
      "discord"
      "espanso"
      "firefox-developer-edition"
      "kitty"
      "libreoffice"
      "obsidian"
      "visual-studio-code"
      "vivaldi"
      "logi-options-plus"
    ];

    brews = [
      "php" # For 2fm alfred plugin 
      "openssl" "readline" "sqlite3" "xz" "zlib" "tcl-tk" # Python Build Dependencies
      "asdf"
    ];

  };

}
