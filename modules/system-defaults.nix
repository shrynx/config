{
  config,
  pkgs,
  lib,
  common,
  ...
}:
{
  system.defaults = {
    # Advertising preferences
    CustomUserPreferences."com.apple.AdLib" = {
      allowApplePersonalizedAdvertising = false;
      allowIdentifierForAdvertising = false;
    };

    # Screenshot configuration
    screencapture = {
      target = "file";
      location = "~/Pictures/screenshots";
    };

    # Finder preferences
    finder = {
      FXPreferredViewStyle = "clmv";
      AppleShowAllExtensions = true;
      ShowPathbar = true;
    };

    # Login window settings
    loginwindow.GuestEnabled = false;

    # Global domain settings
    NSGlobalDomain = {
      AppleICUForce24HourTime = true;
      AppleInterfaceStyle = "Dark";
      NSDocumentSaveNewDocumentsToCloud = false;
    };

    # Dock configuration
    dock = {
      # Dock behavior
      autohide = true;
      minimize-to-application = true;
      mru-spaces = false;
      show-recents = false;
      static-only = false;

      # Folders in dock
      persistent-others = [
        "${common.homeDirectory}/Downloads"
        "~/Applications"
      ];

      # Apps in dock
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
}
