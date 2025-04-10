{
  description = "shriyans nix darwin setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util.url = "github:hraban/mac-app-util";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core.url = "github:homebrew/homebrew-core";
    homebrew-cask.url = "github:homebrew/homebrew-cask";
    homebrew-pakerwreah.url = "github:pakerwreah/homebrew-calendr";
  };

  outputs =
    {
      self,
      nix-darwin,
      mac-app-util,
      nix-homebrew,
      homebrew-core,
      homebrew-cask,
      homebrew-pakerwreah,
      home-manager,
      ...
    }:
    let
      # Import common variables
      common = import ./lib/common.nix;
      inherit (common) username hostname system;
    in
    {
      # Build darwin flake using:
      darwinConfigurations.${hostname} = nix-darwin.lib.darwinSystem {
        inherit system;
        specialArgs = { inherit common; };
        modules = [
          (
            { config, ... }:
            {
              homebrew.taps = builtins.attrNames config.nix-homebrew.taps;
            }
          )
          # Mac app util
          mac-app-util.darwinModules.default

          # Homebrew module
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = username;
              taps = {
                "homebrew/homebrew-core" = homebrew-core;
                "homebrew/homebrew-cask" = homebrew-cask;
                "pakerwreah/homebrew-calendr" = homebrew-pakerwreah;
              };
              mutableTaps = false;
            };
          }

          # Home manager module
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./home.nix;
            home-manager.extraSpecialArgs = { inherit common; };
          }

          # Import all modular configurations
          ./modules/homebrew.nix
          ./modules/packages
          ./modules/system-config.nix
          ./modules/macos-defaults.nix

          # Set Git commit hash for darwin-version
          {
            system.configurationRevision = self.rev or self.dirtyRev or null;
          }
        ];
      };
    };
}
