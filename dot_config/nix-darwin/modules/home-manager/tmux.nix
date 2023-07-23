{ pkgs, ... }: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    mouse = true; 
    historyLimit = 10000;
    baseIndex = 1;
    plugins = with pkgs.tmuxPlugins; [
      sensible
      battery
      {
        plugin = dracula;
        extraConfig = ''
          set -g @dracula-show-battery true
          set -g @dracula-show-powerline false
          # set -g @dracula-show-right-sep |
          # set -g @dracula-show-left-sep |
          set -g @dracula-left-icon-padding 1
          set -g @dracula-refresh-rate 10
          set -g @dracula-git-disable-status true
          set -g @dracula-show-left-icon session
          set -g @dracula-show-flags true
          set -g @dracula-show-location false
        '';
      }
      fuzzback
      yank
    ];
    extraConfig = ''
      set -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"
    '';
  };
}