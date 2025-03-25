{
  description = "shriyans nix darwin setup";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      mac-app-util,
      nix-homebrew,
      homebrew-core,
      homebrew-cask,
      nixpkgs,
      home-manager,
    }:
    let
      configuration =
        { pkgs, ... }:
        let
          # Import custom packages
          customPackages = import ./packages { inherit pkgs; };
        in
        {
          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = with pkgs; [
            git
            zsh
            neovim
            devenv
            devbox
            direnv
            nixfmt-rfc-style
            starship
            lsd
            bat
            eza
            dust
            zellij
            procs
            sd
            customPackages.popcorn-time
          ];

          fonts.packages = with pkgs; [
            nerd-fonts.fira-code
          ];

          homebrew = {
            enable = true;
            brews = [
              "mas"
            ];
            casks = [
              "docker"
              "whatsapp"
              "the-unarchiver"
              "maccy"
              "betterdisplay"
              "finicky"
              "google-chrome"
              "warp"
              "intellij-idea-ce"
              "gitkraken"
              "tailscale"
              "visual-studio-code"
              "signal"
              "qgis"
              "dbeaver-community"
              "mattermost"
              "spotify"
              "vlc"
              "webtorrent"
              "cursor"
            ];
            masApps = {
              "Bitwarden" = 1352778147;
            };
            onActivation = {
              cleanup = "zap";
              autoUpdate = true;
              upgrade = true;
            };
          };
          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";
          nixpkgs.config.allowUnfree = true;

          # Enable alternative shell support in nix-darwin.
          programs.zsh.enable = true;

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 6;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";
          security.pam.services.sudo_local.touchIdAuth = true;

          users.users.shriyans = {
            name = "shriyans";
            home = "/Users/shriyans";
          };
          system.defaults = {
            CustomUserPreferences."com.apple.AdLib" = {
              allowApplePersonalizedAdvertising = false;
              allowIdentifierForAdvertising = false;
            };
            screencapture = {
              target = "file";
              location = "~/Pictures/screenshots";
            };
            finder = {
              FXPreferredViewStyle = "clmv";
              AppleShowAllExtensions = true;
              ShowPathbar = true;
            };
            loginwindow.GuestEnabled = false;
            NSGlobalDomain = {
              AppleICUForce24HourTime = true;
              AppleInterfaceStyle = "Dark";
              NSDocumentSaveNewDocumentsToCloud = false;
            };
            dock = {
              autohide = true;
              minimize-to-application = true;
              mru-spaces = false;
              show-recents = false;
              static-only = false;
              persistent-others = [
                "/Users/shriyans/Downloads"
                "~/Applications"
              ];
              persistent-apps = [
                {
                  spacer = {
                    small = true;
                  };
                }
                "/Applications/WhatsApp.app"
                "/Applications/Spotify.app"
                "/Applications/Google Chrome.app"
                "/Applications/GitKraken.app"
                "/Applications/Warp.app"
                "/Applications/Visual Studio Code.app"
                "/Applications/Cursor.app"
                "/Applications/IntelliJ IDEA CE.app"
                "/Applications/Mattermost.app"
                {
                  spacer = {
                    small = true;
                  };
                }
              ];
            };
          };
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Shriyanss-MacBook-Pro
      darwinConfigurations."Shriyanss-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        modules = [
          mac-app-util.darwinModules.default
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              # Install Homebrew under the default prefix
              enable = true;

              # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
              enableRosetta = true;

              # User owning the Homebrew prefix
              user = "shriyans";

              # Optional: Declarative tap management
              taps = {
                "homebrew/homebrew-core" = homebrew-core;
                "homebrew/homebrew-cask" = homebrew-cask;
              };

              # Optional: Enable fully-declarative tap management
              #
              # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
              mutableTaps = false;
            };
          }
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.shriyans = import ./home.nix;
          }
          configuration
        ];
      };
    };
}
