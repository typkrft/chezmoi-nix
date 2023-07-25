{ pkgs, nix-vars, ... }: {
  programs.kitty = {
    enable = true;
    package = pkgs.runCommand "kitty-0.0.0" { } "mkdir $out";
    theme = nix-vars.themes.kittyTheme;
    shellIntegration.enableZshIntegration = true;

    darwinLaunchOptions = [
      "--single-instance"
      "--listen-on=unix:/tmp/kitty-socket"
    ];

    font = {
      name = nix-vars.themes.font; #+ "Mono";
      size = 16;
    };

    settings = {
      scrollback_lines = 10000;
      tab_bar_edge = "bottom";
      macos_colorspace = "displayp3";
      macos_option_as_alt = "yes";
      shell_integration = "enabled";
      hide_window_decorations = "titlebar-only";
      focus_follows_mouse = "yes";
      mouse_hide_wait = -1;
      copy_on_select = "yes";
      bell_on_tab = " ";
      window_padding_width = "0 4 0 4";
      symbol_map = "U+23FB-U+23FE,U+2665,U+26A1,U+2B58,U+E000-U+E00A,U+E0A0-U+E0A3,U+E0B0-U+E0C8,U+E0CA,U+E0CC-U+E0D2,U+E0D4,U+E200-U+E2A9,U+E300-U+E3E3,U+E5FA-U+E62F,U+E700-U+E7C5,U+F000-U+F2E0,U+F300-U+F31C,U+F400-U+F4A9,U+F500-U+F8FF Symbols Nerd Font";
    };

    # kitty +kitten show_key
    extraConfig = ''
      map cmd+b send_text normal,application \x02
      map cmd+k send_text normal,application \f
      map cmd+left send_text normal,application \x01
      map cmd+right send_text normal,application \x05
    
      map cmd+backspace send_text normal,application ⌘⌫
    
      map alt+left send_text normal,application ⌥<-
      map alt+right send_text normal,application ⌥->

      map cmd+z send_text normal,application ⌘z
      map cmd+shift+z send_text normal,application ⌘⇪z
    '';
  };
}
