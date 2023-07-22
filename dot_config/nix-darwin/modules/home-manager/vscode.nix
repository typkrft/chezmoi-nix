{ pkgs, ...}: {
  programs.vscode = {
    enable = true;
    enableExtensionUpdateCheck = true;
    enableUpdateCheck = true;
    package = pkgs.runCommand "vscode-0.0.0" { 
      version = "1.8.0";
      pname = "vscode";
    } "mkdir $out";

    extensions = with pkgs.vscode-marketplace; [
      dracula-theme.theme-dracula
      redhat.vscode-yaml
      pkgs.vscode-marketplace."4ops".packer
      aaron-bond.better-comments
      alefragnani.bookmarks
      beardedbear.beardedicons
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
      wayou.vscode-todo-highlight
      yzhang.markdown-all-in-one
    ];
  };

  home.file."Library/Application Support/Code/User/settings.json" = {
    enable = true;
    text = builtins.toJSON {
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
      ];
      "dashyeah.folderSizing" = "col-12";
      "[jsonc]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
    };
  };


}
