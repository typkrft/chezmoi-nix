{
  description = "nix-darwin base configuration";

  inputs = {
    # Packages
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # Software Configs
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Darwin System Config
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # VS Code Extensions
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    # NUR
    nur.url = github:nix-community/NUR;

    # Variables
    nix-vars.url = "path:./modules/inputs/nix-vars";
  };

  # the `= inputs:` just allows us to pass any of the inputs into the outputs section
  outputs = inputs@{ self, nixpkgs, home-manager, darwin, nix-vars, nur, ... }: {
    # Nix Configuration
    system.stateVersion = 23.11; # Esnure compatability with this version of nixos

    # Per System Configuration
    # This is saying that brandons-m2 will be configured by the darwinSystem function in the darwin module defined in inputs
    darwinConfigurations."brandons-m2" = inputs.darwin.lib.darwinSystem {
      # Tell darwinConfigurations that we are a aarch64 system and our nixpkgs module that we should use that architecture
      system = "aarch64-darwin";

      # Inherit inputs
      specialArgs = { inherit inputs nix-vars; };

      pkgs = import nixpkgs {
        system = "aarch64-darwin";
        config.allowUnfree = true;
        config.input-fonts.acceptLicense = true;
        overlays = [
          inputs.nix-vscode-extensions.overlays.default
          inputs.nur.overlay
        ];
        config.experimental-features = ''
          nix-command
          flakes
        '';
      };

      modules = [
        ./modules/nix-darwin/defaults.nix
        ./modules/nix-darwin/fonts.nix
        ./modules/nix-darwin/packages.nix
        ./modules/nix-darwin/yabai.nix
        ./modules/nix-darwin/keyboard.nix
        ./modules/nix-darwin/skhd.nix
        ./modules/nix-darwin/shell.nix

        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users."${nix-vars.username}" = { nix-vars, pkgs, ... }: {
              imports = [
                ./modules/home-manager/defaults.nix
                ./modules/home-manager/zsh.nix
                ./modules/home-manager/kitty.nix
                ./modules/home-manager/navi.nix
                ./modules/home-manager/firefox.nix
                ./modules/home-manager/vscode.nix
                ./modules/home-manager/tmux.nix
                ./modules/home-manager/zellij.nix
                ./modules/home-manager/espanso.nix
                ./modules/home-manager/alfred.nix
                ./private/ssh/nix/ssh.nix
              ];
            };
            extraSpecialArgs = { inherit nix-vars; };
          };
        }

      ];
    };
  };
}
