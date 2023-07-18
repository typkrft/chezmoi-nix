{ ... }: {
  services.skhd.enable = true;
  
  # TODO Keys for stacking and inserting
  services.skhd.skhdConfig = ''
    rctrl - k : yabai -m window --focus north
    rctrl - j : yabai -m window --focus south
    rctrl - l : yabai -m window --focus east
    rctrl - h : yabai -m window --focus west
        
    shift + rctrl - k : yabai -m window --swap north 
    shift + rctrl - j : yabai -m window --swap south
    shift + rctrl - l : yabai -m window --swap east
    shift + rctrl - h : yabai -m window --swap west 
        
    rctrl + alt - k : yabai -m window --warp north 
    rctrl + alt - j : yabai -m window --warp south
    rctrl + alt - l : yabai -m window --warp east
    rctrl + alt - h : yabai -m window --warp west 
        
    rctrl - r : yabai -m space --rotate 270
    rctrl - y : yabai -m space --mirror y-axis
    rctrl - x : yabai -m space --mirror x-axis
    rctrl - s : yabai -m window --toggle split
        
    rctrl - f : yabai -m window --toggle float --grid 4:4:1:1:2:2
    rctrl - z : yabai -m window --toggle zoom-fullscreen
    rctrl - t : yabai -m window --toggle topmost
    rctrl - i : yabai -m window --toggle sticky

    rctrl - 1 : yabai -m space --focus 1 
    rctrl - 2 : yabai -m space --focus 2 
    rctrl - 3 : yabai -m space --focus 3 
    rctrl - 4 : yabai -m space --focus 4 
    rctrl - 5 : yabai -m space --focus 5 
    rctrl - 6 : yabai -m space --focus 6 
    rctrl - 7 : yabai -m space --focus 7 
    rctrl - 8 : yabai -m space --focus 8 
    rctrl - 9 : yabai -m space --focus 9

    shift + rctrl - 1 : yabai -m window --space 1 
    shift + rctrl - 2 : yabai -m window --space 2 
    shift + rctrl - 3 : yabai -m window --space 3 
    shift + rctrl - 4 : yabai -m window --space 4 
    shift + rctrl - 5 : yabai -m window --space 5 
    shift + rctrl - 6 : yabai -m window --space 6 
    shift + rctrl - 7 : yabai -m window --space 7 
    shift + rctrl - 8 : yabai -m window --space 8 
    shift + rctrl - 9 : yabai -m window --space 9

    rctrl - space : yabai -m window --swap largest

    rctrl + shift - left : yabai -m window --resize left:-150:0 || yabai -m window --resize right:-150:0 || yabai -m window --resize left:150:0 || yabai -m window --resize right:150:0
    rctrl + shift - right : yabai -m window --resize left:150:0 || yabai -m window --resize right:150:0 || yabai -m window --resize left:-150:0 || yabai -m window --resize right:-150:0
    rctrl + shift - up : yabai -m window --resize top:0:-150 || yabai -m window --resize bottom:0:-150 || yabai -m window --resize top:0:150 || yabai -m window --resize bottom:0:150
    rctrl + shift - down : yabai -m window --resize top:0:150 || yabai -m window --resize bottom:0:150 || yabai -m window --resize top:0:-150 || yabai -m window --resize bottom:0:-150
  '';
}
