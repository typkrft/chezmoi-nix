{ nix-vars, pkgs, ... }: {
  services.yabai = {
    enable = true;

    #! SA currently broken on sonoma developer beta 4
    extraConfig = ''
      #yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
      #sudo yabai --load-sa
      
      yabai -m config active_window_border_color 0xFFBD93F9
      yabai -m config bottom_padding 6
      yabai -m config focus_follows_mouse autoraise
      yabai -m config insert_feedback_color 0xFF50FA7B
      yabai -m config layout bsp
      yabai -m config left_padding 6
      yabai -m config mouse_action1 move
      yabai -m config mouse_action2 resize
      yabai -m config mouse_drop_action swap
      yabai -m config mouse_modifier ctrl
      yabai -m config normal_window_border_color 0xFF6272A4
      yabai -m config right_padding 6
      yabai -m config top_padding 6
      yabai -m config window_border on
      yabai -m config window_border_blur off
      yabai -m config window_border_radius 12
      yabai -m config window_border_width 2
      yabai -m config window_gap 10
      yabai -m config window_shadow float
      yabai -m config window_zoom_persist on
      yabai -m rule --add app="^Authy Desktop$|^Bitwarden$|^System Settings$" sticky=on layer=above
      yabai -m rule --add app="^Screens$" title!="Screens Library"  manage=off layer=above
      yabai -m rule --add app="^Finder$" title="Copy"  manage=off layer=above

      yabai -m signal --add event=window_created action="sketchybar -m --trigger yabai_window &> /dev/null"
      yabai -m signal --add event=window_destroyed action="sketchybar -m --trigger yabai_window &> /dev/null"
      yabai -m signal --add event=window_focused action="sketchybar -m --trigger yabai_window &> /dev/null"
      yabai -m signal --add event=space_changed action="sketchybar -m --trigger yabai_window &> /dev/null"
      yabai -m signal --add event=window_title_changed action="sketchybar -m --trigger yabai_window &> /dev/null"
    '';


  #! yabai is not being installed and setup properly. Use only extraConfig for everything and look at ~/.config/u-nix/post/nix/yabai
  # enableScriptingAddition = true;

  #   config = {
  #     mouse_modifier = "ctrl";
  #     mouse_action1 = "move";
  #     mouse_action2 = "resize";
  #     mouse_drop_action = "swap";
  #     focus_follows_mouse = "autoraise";

  #     window_border = "on";
  #     window_border_blur = "off";
  #     # window_border_hidpi = "on";
  #     window_border_width = 2;
  #     window_border_radius = 12;
  #     window_shadow = "float";

  #     layout = "bsp";
  #     window_zoom_persist = "on";
  #     top_padding = 6;
  #     bottom_padding = 6;
  #     left_padding = 6;
  #     right_padding = 6;
  #     window_gap = 10;

  #     active_window_border_color = "0xFF${nix-vars.themes.dracula.hex.purple}";
  #     normal_window_border_color = "0xFF${nix-vars.themes.dracula.hex.comment}";
  #     insert_feedback_color = "0xFF${nix-vars.themes.dracula.hex.green}";
  #   };

  #   # TODO Send Apps to spaces
  #   extraConfig = ''
  #     yabai -m rule --add app="^Authy Desktop$|^Bitwarden$|^System Settings$" sticky=on layer=above
  #     yabai -m rule --add app="^Screens$" title!="Screens Library"  manage=off layer=above
  #     yabai -m rule --add app="^Finder$" title="Copy"  manage=off layer=above

  #     yabai -m signal --add event=window_created action="sketchybar -m --trigger yabai_window &> /dev/null"
  #     yabai -m signal --add event=window_destroyed action="sketchybar -m --trigger yabai_window &> /dev/null"
  #     yabai -m signal --add event=window_focused action="sketchybar -m --trigger yabai_window &> /dev/null"
  #     yabai -m signal --add event=space_changed action="sketchybar -m --trigger yabai_window &> /dev/null"
  #     yabai -m signal --add event=window_title_changed action="sketchybar -m --trigger yabai_window &> /dev/null"
  #   '';
  };
}