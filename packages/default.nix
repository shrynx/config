{
  pkgs ? import <nixpkgs> { },
}:
{
  popcorn-time = pkgs.callPackage ./popcorn-time.nix { };
}
