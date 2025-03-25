{
  lib,
  stdenv,
  fetchzip,
  undmg,
}:

let
  isAarch64 = stdenv.hostPlatform.system == "aarch64-darwin";
  version = "0.5.1";

  src = fetchzip {
    url =
      if isAarch64 then
        "https://github.com/popcorn-official/popcorn-desktop/releases/download/v${version}/Popcorn-Time-${version}-osxarm64.zip"
      else
        "https://github.com/popcorn-official/popcorn-desktop/releases/download/v${version}/Popcorn-Time-${version}-osx64.zip";

    sha256 =
      if isAarch64 then
        "sha256-z9MoLLLjGfBjEOh5cCi9VUmAZAU37HvQHE9S7gZKPQc="
      else
        "sha256-Ym6QFzvllBm/ShSFXyjvjny1njcqI5UsFD/8kmKBrDU=";

    stripRoot = false;
  };
in
stdenv.mkDerivation {
  pname = "popcorn-time";
  inherit version src;

  buildInputs = [ undmg ];

  installPhase = ''
    mkdir -p $out/Applications
    cp -r "Popcorn-Time.app" $out/Applications/
  '';

  meta = with lib; {
    description = "A multi-platform torrent client";
    homepage = "https://github.com/popcorn-official/popcorn-desktop";
    license = licenses.gpl3;
    platforms = platforms.darwin;
    maintainers = [ ];
  };
}
