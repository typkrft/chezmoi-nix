{ pkgs, ... }: {
  environment = with pkgs; {
    shells = [
      bash
      zsh
    ];
    loginShell = zsh;
  };

  programs.zsh = {
    enable = true;
  };

  # Touch ID for sudo auth
  security.pam.enableSudoTouchIdAuth = true;
}
