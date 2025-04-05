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
    nixfmt-rfc-style

    # Command-line utilities
    starship
    lsd
    bat
    eza
    dust
    zellij
    procs
    sd
    nushell

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
