{
  ...
}:

{
  # Homebrew configuration
  homebrew = {
    enable = true;

    # CLI tools from Homebrew
    brews = [
      "mas"
      "bitwarden-cli"
    ];

    # GUI applications from Homebrew
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
      "zed"
      "calendr"
      "topnotch"
      "claude"
      "loom"
      "gitbutler"
      "kitty"
      "ghostty"
      "huly"
      "raycast"
    ];

    # Mac App Store applications
    masApps = {
      "Bitwarden" = 1352778147;
    };

    # Cleanup and update settings
    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
  };
}
