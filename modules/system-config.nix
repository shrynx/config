{
  common,
  ...
}:

{
  # Necessary for using flakes on this system
  nix.settings = {
    experimental-features = "nix-command flakes";
    trusted-users = [
      "root"
      common.username
    ];
  };

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

  system.activationScripts.postUserActivation.text = ''
    # Following line should allow us to avoid a logout/login cycle when changing settings
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';

  # The platform the configuration will be used on
  nixpkgs.hostPlatform = common.system;

}
