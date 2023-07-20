{ config, pkgs, nix-vars, ... }: {
  # !Requirements for Nix/Nix-Darwin
  system.stateVersion = 4; # Backwards Compatability
  services.nix-daemon.enable = true; # Required by nix-darwin
  programs.zsh.enable = true; # Lose important Nix Paths if disabled
  users.users."${nix-vars.username}".home = "/Users/${nix-vars.username}";  # Avoid /var/empty warnings/errors  

  # macOS Defaults
  system.defaults = {
    dock = {
      autohide = true;
      minimize-to-application = true; 
      mru-spaces = false;
      show-recents = false;
      
      # Hot Corners
      wvous-tl-corner = 2;  # Mission Control
      wvous-tr-corner = 12; # Notification Center
      wvous-bl-corner = 14; # Quick Note
      wvous-br-corner = 4;  # Desktop
    };
    
    finder = {
      AppleShowAllExtensions = true;
      _FXShowPosixPathInTitle = true;
      CreateDesktop = false;
      FXDefaultSearchScope = "SCcf";
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "clmv";
    };
    

    ".GlobalPreferences"."com.apple.sound.beep.sound" = "/System/Library/Sounds/hero";

    screencapture = {
      disable-shadow = true;
      location = "~/Downloads/Screenshots";
    };

    CustomUserPreferences = {
      "com.apple.print.PrintingPrefs" = { "Quit When Finished" = true; }; # quit printer app once jobs complete
      "com.apple.AdLib" = { allowApplePersonalizedAdvertising = false; };
      
      "com.apple.SoftwareUpdate" = {
        AutomaticCheckEnabled = true;
        # Check for software updates daily, not just once per week
        ScheduleFrequency = 1;
        # Download newly available updates in background
        AutomaticDownload = 1;
        # Install System data files & security updates
        CriticalUpdateInstall = 1;
      };
      
      "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };

      "com.apple.screensaver" = {
          # Require password immediately after sleep or screen saver begins
          askForPassword = 1;
          askForPasswordDelay = 0;
        };
    };

    NSGlobalDomain = {
      _HIHideMenuBar = true;
      "com.apple.swipescrolldirection" = true;
      AppleICUForce24HourTime = true;
      AppleInterfaceStyle = "Dark";
      AppleKeyboardUIMode = 3;
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true; 
      "com.apple.trackpad.scaling" = 2.4;
    };
  };
}