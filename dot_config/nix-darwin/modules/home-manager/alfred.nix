{ pkgs, config, ... }: {
  # TODO: Template this 
  home.file."Library/Application Support/Alfred/Alfred.alfredpreferences/themes/typkrft-custom/theme.json" = {
    enable = true;
    text = builtins.toJSON {
      "alfredtheme" = {
        "result" = {
          "textSpacing" = 5;
          "subtext" = {
            "size" = 12;
            "colorSelected" = "#BD92F8FF";
            "font" = "Iosevka Nerd Font";
            "color" = "#6271A3FF";
          };
          "shortcut" = {
            "size" = 16;
            "colorSelected" = "#FFB86CFF";
            "font" = "Iosevka Nerd Font";
            "color" = "#FFB86CFF";
          };
          "backgroundSelected" = "#44465AFF";
          "text" = {
            "size" = 18;
            "colorSelected" = "#50FA7BFF";
            "font" = "Iosevka Nerd Font";
            "color" = "#FFFFFFCB";
          };
          "iconPaddingHorizontal" = 7;
          "roundness" = 8;
          "paddingVertical" = 3;
          "iconSize" = 40;
        };
        "search" = {
          "backgroundSelected" = "#358188FF";
          "paddingHorizontal" = 7;
          "spacing" = 15;
          "text" = {
            "size" = 36;
            "colorSelected" = "#FFFFFFFF";
            "font" = "Iosevka Nerd Font";
            "color" = "#F7F7F1FF";
          };
          "background" = "#282A3600";
          "roundness" = 13;
          "paddingVertical" = 5;
        };
        "window" = {
          "color" = "#282A367F";
          "paddingHorizontal" = 9;
          "width" = 842;
          "borderPadding" = 0;
          "borderColor" = "#0000007F";
          "blur" = 0;
          "roundness" = 15;
          "paddingVertical" = 9;
        };
        "credit" = "typkrft";
        "visualEffectMode" = 2;
        "separator" = {
          "color" = "#CBCBCBF3";
          "thickness" = 0;
        };
        "scrollbar" = {
          "color" = "#BD92F8FF";
          "thickness" = 2;
        };
        "name" = "typkrft-custom";
      };
    };
  };
}
