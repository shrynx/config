{
  pkgs,
  lib,
  common,
  config,
  ...
}:
let
  homeDir = config.home.homeDirectory;
  sshDir = "${homeDir}/.ssh";
  sopsAgeKeyFile = "${homeDir}/.config/sops/age/keys.txt";
in
{

  home.username = common.username;
  home.homeDirectory = common.homeDirectory;

  ## Dotfiles
  home.file =
    let
      dotfilesPath = ./dotfiles;
    in
    lib.mapAttrs (
      name: type:
      if type == "directory" then
        {
          source = "${dotfilesPath}/${name}";
          recursive = true;
        }
      else
        {
          source = "${dotfilesPath}/${name}";
        }
    ) (builtins.readDir dotfilesPath);

  ## SOPS secrets
  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.keyFile = sopsAgeKeyFile;
    secrets = {
      "id_personal" = {
        path = "${sshDir}/id_personal";
        mode = "0600";
      };
      "id_personal_pub" = {
        path = "${sshDir}/id_personal.pub";
        mode = "0644";
      };
      "id_work" = {
        path = "${sshDir}/id_work";
        mode = "0600";
      };
      "id_work_pub" = {
        path = "${sshDir}/id_work.pub";
        mode = "0644";
      };
      "allowed_signers" = {
        path = "${sshDir}/allowed_signers";
        mode = "0644";
      };
      "personal_gitconfig" = {
        path = "${homeDir}/.personal.gitconfig";
        mode = "0755";
      };
      "work_gitconfig" = {
        path = "${homeDir}/.work.gitconfig";
        mode = "0755";
      };
    };
  };

  ## Session environment
  home.sessionVariables = {
    SOPS_AGE_KEY_FILE = sopsAgeKeyFile;
  };

  ## Create directories & customize sidebar
  home.activation =
    let
      mysidesBin = "${pkgs.mysides}/bin/mysides";
      sidebarItems = [
        {
          name = "Home";
          path = "${homeDir}";
        }
        {
          name = "Work";
          path = "${homeDir}/Work";
        }
        {
          name = "Projects";
          path = "${homeDir}/Projects";
        }
        {
          name = "Art";
          path = "${homeDir}/Art";
        }
        {
          name = "Screenshots";
          path = "${homeDir}/Pictures/screenshots";
        }
      ];
      createDirs = ''mkdir -p ${lib.concatStringsSep " " (map (item: item.path) sidebarItems)}'';
      removeSidebarScript = lib.concatStringsSep "\n" (
        map (item: "${mysidesBin} remove ${item.name} >/dev/null 2>&1 || true") sidebarItems
      );
      addSidebarScript = lib.concatStringsSep "\n" (
        map (
          item: ''${mysidesBin} add ${item.name} "file://${item.path}" >/dev/null 2>&1 || true''
        ) sidebarItems
      );
    in
    {
      createUserDirectories = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        ${createDirs}
      '';

      addToSidebar = lib.hm.dag.entryAfter [ "createUserDirectories" ] ''
        ${removeSidebarScript}
        ${addSidebarScript}
      '';
    };

  ## Session path
  home.sessionPath = [
    "/run/current-system/sw/bin"
    "$HOME/.nix-profile/bin"
  ];

  ## ZSH shell
  programs.zsh = {
    enable = true;
    initContent = ''
      export PATH=/run/current-system/sw/bin:$HOME/.nix-profile/bin:$PATH
      . '$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh'
      if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
        . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
      fi
    '';
  };

  programs.home-manager.enable = true;

  home.stateVersion = "23.05";
}
