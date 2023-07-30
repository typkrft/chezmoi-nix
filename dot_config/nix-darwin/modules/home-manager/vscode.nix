{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = true;
    enableUpdateCheck = true;
    package = pkgs.runCommand "vscode-0.0.0"
      {
        version = "1.8.1";
        pname = "vscode";
      } "mkdir $out";

    extensions = with pkgs.vscode-marketplace; [
      dracula-theme.theme-dracula
      redhat.vscode-yaml
      pkgs.vscode-marketplace."4ops".packer
      aaron-bond.better-comments
      alefragnani.bookmarks
      beardedbear.beardedicons
      ivhernandez.vscode-plist
      bierner.markdown-mermaid
      bobmagicii.dashyeah
      canadaduane.vscode-kmonad
      charliermarsh.ruff
      christian-kohler.path-intellisense
      esbenp.prettier-vscode
      formulahendry.code-runner
      github.remotehub
      gruntfuggly.todo-tree
      hashicorp.terraform
      ibm.output-colorizer
      imagio.vscode-dimmer-block
      janisdd.vscode-edit-csv
      jnoortheen.nix-ide
      kamikillerto.vscode-colorize
      mechatroner.rainbow-csv
      mgesbert.python-path
      ms-azuretools.vscode-docker
      ms-python.python
      ms-vscode-remote.remote-containers
      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-ssh-edit
      ms-vscode.remote-explorer
      ms-vscode.remote-repositories
      ms-vscode.remote-server
      redhat.ansible
      redhat.vscode-yaml
      shd101wyy.markdown-preview-enhanced
      sumneko.lua
      tamasfe.even-better-toml
      timonwong.shellcheck
      tomoki1207.pdf
      yzhang.markdown-all-in-one
      # wayou.vscode-todo-highlight
    ];
  };

  home.file."Library/Application Support/Code/User/settings.json" = {
    enable = true;
    text = builtins.toJSON {
      "window.restoreWindows" = "all";
      "files.autoSave" = "afterDelay";
      "files.hotExit" = "onExitAndWindowClose";
      "workbench.colorTheme" = "Dracula";
      "dashyeah.title" = "Projects";
      "dashyeah.debug" = false;
      "dashyeah.database" = [
        {
          "id" = "1544ea86-689d-43ad-8347-745aeb6fdf1a";
          "name" = "Chezmoi";
          "path" = "file:///Users/brandon/.local/share/chezmoi";
          "icon" = "codicon-folder";
          "accent" = "#dc143c";
        }

        {
          "id" = "0292120e-ed39-4d36-bf09-f3dda5caa4f4";
          "name" = "bartender";
          "path" = "file:///Users/brandon/.local/share/chezmoi";
          "icon" = "codicon-folder";
          "accent" = "#dc143c";
        }

      ];
      "dashyeah.folderSizing" = "col-12";

      "[jsonc]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[javascript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };

      "better-comments.tags" = [
        {
          "tag" = "!";
          "color" = "#FF2D00";
          "strikethrough" = false;
          "underline" = false;
          "backgroundColor" = "transparent";
          "bold" = false;
          "italic" = false;
        }
        {
          "tag" = "?";
          "color" = "#3498DB";
          "strikethrough" = false;
          "underline" = false;
          "backgroundColor" = "transparent";
          "bold" = false;
          "italic" = false;
        }
        {
          "tag" = "//";
          "color" = "#474747";
          "strikethrough" = true;
          "underline" = false;
          "backgroundColor" = "transparent";
          "bold" = false;
          "italic" = false;
        }
        {
          "tag" = "todo";
          "color" = "#FF8C00";
          "strikethrough" = false;
          "underline" = false;
          "backgroundColor" = "transparent";
          "bold" = false;
          "italic" = false;
        }
        {
          "tag" = "*";
          "color" = "#98C379";
          "strikethrough" = false;
          "underline" = false;
          "backgroundColor" = "transparent";
          "bold" = false;
          "italic" = false;
        }
      ];

      "debug.console.fontSize" = 14;
      "terminal.integrated.fontSize" = 14;
      "shellcheck.exclude" = [ "SC1071" ];

      "editor.fontFamily" = "Iosevka Nerd Font";
      "editor.fontLigatures" = true;
      "editor.fontSize" = 14;
      "editor.tokenColorCustomizations" = {
        "[Dracula]" = {
          "textMateRules" = [
            {
              "scope" = "comment";
              "settings" = {
                "fontStyle" = "italic";
              };
            }
          ];
        };
      };

      "workbench.iconTheme" = "bearded-icons";
      "todo-tree.highlights.enabled" = false;
      "[markdown]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[yaml]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "colorize.languages" = [
        "css"
        "sass"
        "scss"
        "less"
        "postcss"
        "sss"
        "stylus"
        "xml"
        "svg"
        "toml"
      ];
    };
  };
}
