{
  pkgs,
  ...
}:
let
  # Import custom packages
  customPackages = import ./custom { inherit pkgs; };
in
{
  # Nixpkgs configuration
  nixpkgs.config.allowUnfree = true;

  # CLI tools and utilities installed system-wide
  environment.systemPackages = with pkgs; [
    # Development tools
    git
    neovim
    devenv
    devbox
    direnv
    nixd
    nil
    nixfmt-rfc-style

    # Command-line utilities
    # yazi utils
    file
    ffmpeg
    p7zip
    jq
    poppler
    fd
    ripgrep
    resvg
    imagemagick

    yazi
    starship
    lsd
    bat
    dust
    zellij
    zoxide
    procs
    sd
    nushell
    atuin
    fzf
    wget
    darwin.trash

    # Apps
    customPackages.popcorn-time
  ];

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.hack
    nerd-fonts.hasklug
    nerd-fonts.jetbrains-mono
  ];
}
