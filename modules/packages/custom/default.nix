{
  pkgs ? import <nixpkgs> { },
}:
{
  popcorn-time = pkgs.callPackage ./popcorn-time.nix { };
  neovim-wrapped = pkgs.callPackage ./neovim-wrapped.nix { };
}
