{
  config,
  pkgs,
  lib,
  common,
  ...
}:

{
  # Necessary for using flakes on this system
  nix.settings.experimental-features = "nix-command flakes";

  # Enable alternative shell support in nix-darwin
  programs.zsh.enable = true;

  # Security settings - TouchID for sudo
  security.pam.services.sudo_local.touchIdAuth = true;

  # User configuration
  users.users.${common.username} = {
    name = common.username;
    home = common.homeDirectory;
  };

  # System state version
  system.stateVersion = 6;

  # The platform the configuration will be used on
  nixpkgs.hostPlatform = common.system;

}
