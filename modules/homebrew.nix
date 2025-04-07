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
