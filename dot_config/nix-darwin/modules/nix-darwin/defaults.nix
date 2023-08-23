{ config, pkgs, nix-vars, ... }: {
  # !Requirements for Nix/Nix-Darwin
  system.stateVersion = 4; # Backwards Compatability
  services.nix-daemon.enable = true; # Required by nix-darwin

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ]; # Add flakes to the default nix command
      auto-optimise-store = true; # Remove dupe files
    };
    gc = {
      automatic = true; # Auto run Garbage Collections
      interval = {
        Hour = 3;
        Minute = 15;
      }; # When to run garbage collection
    };
  };

  programs = {
    zsh.enable = true; # Lose important Nix Paths if disabled
    nix-index.enable = true;
  };

  users.users."${nix-vars.username}".home = "/Users/${nix-vars.username}"; # Avoid /var/empty warnings/errors  
  # macOS Defaults
  system.defaults = {
    dock = {
      autohide = true;
      minimize-to-application = true;
      mru-spaces = false;
      show-recents = false;

      # Hot Corners
      wvous-tl-corner = 2; # Mission Control
      wvous-tr-corner = 12; # Notification Center
      wvous-bl-corner = 14; # Quick Note
      wvous-br-corner = 4; # Desktop
    };

    finder = {
      AppleShowAllExtensions = true;
      _FXShowPosixPathInTitle = true;
      CreateDesktop = false;
      FXDefaultSearchScope = "SCcf";
      FXEnableExtensionChangeWarning = false;
      FXPreferredViewStyle = "clmv";
      ShowPathbar = true;
    };

    ".GlobalPreferences"."com.apple.sound.beep.sound" = "/System/Library/Sounds/hero";

    screencapture = {
      disable-shadow = true;
      location = "~/Downloads/Screenshots";
    };

    CustomUserPreferences = {
      # "com.apple.finder._FXSortFoldersFirst" = true; #todo

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

    # trackpad = {
    #   TrackpadThreeFingerDrag = true; # TODO is this working
    # };

    NSGlobalDomain = {
      _HIHideMenuBar = true;
      "com.apple.swipescrolldirection" = true;
      AppleICUForce24HourTime = true;
      AppleInterfaceStyle = "Dark";
      AppleKeyboardUIMode = 3;
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      AppleShowScrollBars = "WhenScrolling";
      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
      "com.apple.trackpad.scaling" = 2.4;
      AppleWindowTabbingMode = "fullscreen";
      PMPrintingExpandedStateForPrint = true;
      PMPrintingExpandedStateForPrint2 = true;
    };
  };
}
