{
  pkgs,
  nodejs ? pkgs.nodejs_22,
  cargo ? pkgs.cargo,
}:

pkgs.writeShellScriptBin "nvim" ''
  export PATH=${nodejs}/bin:${cargo}/bin:$PATH
  exec ${pkgs.neovim}/bin/nvim "$@"
''
