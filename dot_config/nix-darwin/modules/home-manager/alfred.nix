{ pkgs, ... }: {
 # NOTE: To install workflow move it to /Users/brandon/Library/Application Support/Alfred/Alfred.alfredpreferences/workflows then unzip it 
 # ! fetchzip will fail because of the file extension using #someFileName.zip renames the output so that fetchzip will work

  home.file."Library/Application Support/Alfred/Alfred.alfredpreferences/workflows/bitwarden" = {
    enable = true;
    source = pkgs.fetchzip {
      name = "bitwarden-workflow";
      url = "https://github.com/blacs30/bitwarden-alfred-workflow/releases/download/2.4.7/bitwarden-alfred-workflow.alfredworkflow#bitwarden-alfred.zip";
      sha256 = "sha256-XMpKi5mblbZdZdrC3MX86Uz6FRjaIDYkH0BOKsrFokk=";
      stripRoot = false;
    };
  };

  home.file."Library/Application Support/Alfred/Alfred.alfredpreferences/workflows/2fa" = {
    enable = true;
    source = pkgs.fetchzip {
      name = "2fa-workflow";
      url = "https://github.com/squatto/alfred-imessage-2fa/releases/download/v1.2.8/iMessage.2FA.alfredworkflow#2fa-alfred.zip";
      sha256 = "sha256-zcDndnGdAFCf0ouPZgUj37yLp08YF8MwJ6nV7rTZ8gg=";
      stripRoot = false;
    };
  };

  home.file."Library/Application Support/Alfred/Alfred.alfredpreferences/workflows/paste-plaintext-alfred" = {
    enable = true;
    source = pkgs.fetchzip {
      name = "paste-plaintext-workflow";
      url = "https://github.com/alfredapp/paste-as-plain-text-from-hotkey-workflow/releases/download/2022.2/Paste.as.Plain.Text.from.Hotkey.alfredworkflow#Paste.as.Plain.Text.from.Hotkey.zip";
      sha256 = "sha256-r2KT9xq077g7O9ruTIuScmUCPW3zsvP6n4L351QTAnY=";
      stripRoot = false;
    };
  };

  home.file."Library/Application Support/Alfred/Alfred.alfredpreferences/workflows/mouseless-messenger-alfred" = {
    enable = true;
    source = pkgs.fetchzip {
      name = "mouseless-messenger-workflow";
      url = "https://github.com/stephancasas/alfred-mouseless-messenger/releases/download/v2.0.3/Mouseless.Messenger.alfredworkflow#Mouseless.Messenger.zip";
      sha256 = "sha256-EW8YC58xLqow7NJHxJOh+pujHUUAHmP5xUVRzAL8/YM=";
      stripRoot = false;
    };
  };

  home.file."Library/Application Support/Alfred/Alfred.alfredpreferences/workflows/shimmering-obsidian" = {
    enable = true;
    source = pkgs.fetchzip {
      name = "shimmering-obsidian-workflow";
      url = "https://github.com/chrisgrieser/shimmering-obsidian/releases/download/3.12.8/shimmering-obsidian.alfredworkflow#shimmering-obsidian.zip";
      sha256 = "sha256-Xn6xiqICWStVEzSTQzaEhBPf9VUsMnRIXJeyBxNRQTM=";
      stripRoot = false;
    };
  };

  home.file."Library/Application Support/Alfred/Alfred.alfredpreferences/workflows/menubar-search-alfred" = {
    enable = true;
    source = pkgs.fetchzip {
      name = "menubar-search-workflow";
      url = "https://github.com/BenziAhamed/Menu-Bar-Search/releases/download/v2.0/Menu.Bar.Search.alfredworkflow#menubar-search-obsidian.zip";
      sha256 = "sha256-56OwBb3XeLBatSIPP2njvDK1bju0OQwjAgasTWZq+eA=";
      stripRoot = false;
    };
  };

  home.file."Library/Application Support/Alfred/Alfred.alfredpreferences/workflows/shortcuts-alfred" = {
    enable = true;
    source = pkgs.fetchzip {
      name = "shortcuts-workflow";
      url = "https://github.com/alfredapp/shortcuts-workflow/releases/download/2023.8/Shortcuts.alfredworkflow#Shortcuts.zip";
      sha256 = "sha256-ShI6w7epoSdhspYEX2c8xEflmsWrNGfOS9frtxdz/H8=";
      stripRoot = false;
    };
  };

  home.file."Library/Application Support/Alfred/Alfred.alfredpreferences/workflows/fzf-alfred" = {
    enable = true;
    source = pkgs.fetchzip {
      name = "fzf-workflow";
      url = "https://github.com/yohasebe/fzf-alfred-workflow/raw/main/fzf-alfred-workfow.alfredworkflow#fzf-workflow.zip";
      sha256 = "sha256-JY77vvL9/H095s79tEVT3rS4JCmT9Zq3S3ssXmqA/jk=";
      stripRoot = false;
    };
  };

  home.file."Library/Application Support/Alfred/Alfred.alfredpreferences/workflows/recorder-obsidian" = {
    enable = true;
    source = pkgs.fetchzip {
      name = "recorder-workflow";
      url = "https://github.com/vitorgalvao/start-recording-workflow/releases/download/2023.3/Start.Recording.alfredworkflow#recorder.zip";
      sha256 = "sha256-hhH+AhFyrc6oIBEUPlYE2I5J/WTZHlw6V0IP0iR00IA=";
      stripRoot = false;
    };
  };

  home.file."Library/Application Support/Alfred/Alfred.alfredpreferences/workflows/vscode-obsidian" = {
    enable = true;
    source = pkgs.fetchzip {
      name = "vscode-workflow";
      url = "https://github.com/Acidham/alfred-vscode-workspace-explorer/releases/download/v1.0.0/VSCode.Workspace.Explorer.alfredworkflow#vscode.zip";
      sha256 = "sha256-Fpyj5MCTO1tqUqoPAodhxLjq8OsO2tLLJCX7xRqU8vw=";
      stripRoot = false;
    };
  };

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