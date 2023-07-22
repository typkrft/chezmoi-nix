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

    # Variables
    nix-vars.url = "path:./modules/inputs/nix-vars";
  };

  # the `= inputs:` just allows us to pass any of the inputs into the outputs section
  outputs = inputs@{ self, nixpkgs, home-manager, darwin, nix-vars, ... }: {
    # Nix Configuration
    system.stateVersion = 23.11; # Esnure compatability with this version of nixos
    nix.extraOptions = "experimental-features = nix-command flakes"; # Add flakes to the default nix command # TODO not working
    nix.gc.automatic = true; # Auto run Garbage Collections
    nix.gc.dates = "01:00"; # When to run garbage collection
    nix.settings.auto-optimise-store = true; # Remove dupe files

    # Per System Configuration
    # This is saying that brandons-m2 will be configured by the darwinSystem function in the darwin module defined in inputs
    darwinConfigurations."brandons-m2" = inputs.darwin.lib.darwinSystem {
      # Tell darwinConfigurations that we are a aarch64 system and our nixpkgs module that we should use that architecture
      system = "aarch64-darwin";
      
      # Inherit inputs
      specialArgs = { inherit inputs nix-vars; };
      
      # services.nix-daemon.enable = true; # needed because macOS is a multi-user install
      pkgs = import nixpkgs {
        system = "aarch64-darwin";
        config.allowUnfree = true;
        config.input-fonts.acceptLicense = true;
        overlays = [ inputs.nix-vscode-extensions.overlays.default ];
      };

      modules = [
        ./modules/nix-darwin/defaults.nix
        ./modules/nix-darwin/fonts.nix
        ./modules/nix-darwin/packages.nix
        ./modules/nix-darwin/yabai.nix
        ./modules/nix-darwin/keyboard.nix
        ./modules/nix-darwin/skhd.nix
        ./modules/nix-darwin/shell.nix

        home-manager.darwinModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users."${nix-vars.username}" = { nix-vars, config, pkgs, ... }: {
              imports = [
                ./modules/home-manager/defaults.nix
                ./modules/home-manager/zsh.nix
                ./modules/home-manager/kitty.nix
                ./modules/home-manager/navi.nix
                ./modules/home-manager/firefox.nix
                ./modules/home-manager/vscode.nix
              ];
            };
            extraSpecialArgs = { inherit nix-vars; };
          };
        }

      ];
    };
  };
}
