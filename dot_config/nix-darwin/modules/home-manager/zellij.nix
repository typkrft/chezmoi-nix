{ ... }: {
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    
    settings = {
      # simplified_ui = flase;
      pane_frames = false;
      theme = "dracula";
      ui.pane_frame.rounded_corners = false;
      default_layout = "compact";

      themes.dracula = {
        "fg" = [248 248 242];
        "bg" = [40 42 54];
        "black" =  [40 42 54];
        "red" = [255 85 85];
        "green" = [80 250 123];
        "yellow" = [241 250 140];
        "blue" = [98 114 164];
        "magenta" = [255 121 198];
        "cyan" = [139 233 253];
        "white" = [255 255 255];
        "orange" = [255 184 108];
      };
    };
  };
}

