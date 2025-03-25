{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.username = "shriyans";
  home.homeDirectory = "/Users/shriyans";
  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.activation = {
    createUserDirectories = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      # Create directories if they don't exist
      mkdir -p "$HOME/Work" "$HOME/Art" "$HOME/Projects" "$HOME/Pictures/screenshots"
    '';

    addToSidebar = lib.hm.dag.entryAfter [ "createUserDirectories" ] ''
      MYSIDES="${pkgs.mysides}/bin/mysides"

      # Remove all items first
      for ITEM in "Recents" "Documents" "Home" "Work" "Projects" "Art" "Screenshots"; do
        $MYSIDES remove "$ITEM" >/dev/null 2>&1 || true
      done

      # Add items back with proper paths
      $MYSIDES add "Home" "file://$HOME" >/dev/null 2>&1 || true

      # Add folders in home directory
      for ITEM in "Work" "Projects" "Art"; do
        $MYSIDES add "$ITEM" "file://$HOME/$ITEM" >/dev/null 2>&1 || true
      done

      # Add special locations
      $MYSIDES add "Screenshots" "file://$HOME/Pictures/screenshots" >/dev/null 2>&1 || true
    '';
  };

  home.packages = [
    pkgs.mysides
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".zshrc".source = ./dotfiles/.zshrc;
    ".finicky.js".source = ./dotfiles/.finicky.js;
    ".config" = {
      source = ./dotfiles/config;
      recursive = true;
    };
  };

  home.sessionVariables = { };
  home.sessionPath = [
    "/run/current-system/sw/bin"
    "$HOME/.nix-profile/bin"
  ];
  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    initExtra = ''
      # Add any additional configurations here
      export PATH=/run/current-system/sw/bin:$HOME/.nix-profile/bin:$PATH
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
    '';
  };
}
