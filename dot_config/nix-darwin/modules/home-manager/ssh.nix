{ pkgs, ... }: {
  programs.ssh = {
    enable = true;
    compression = true;
    matchBlocks = {
      "draculas_castle" = {
        hostname = "10.10.10.9";
        port = 2240;
        user = "simon";
        identityFile = "$HOME/.local/chezmoi/private/ssh/keys/draculas_castle";
      };
    };
  };
}