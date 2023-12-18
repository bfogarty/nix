{ stdenv, lib, fetchurl, undmg }:

stdenv.mkDerivation rec {
  name = "arc";
  version = "1.21.1-44329";

  src = fetchurl {
    url = "https://releases.arc.net/release/Arc-${version}.dmg";
    sha256 = "sha256-PJf0q5lz0P5DjxLNkC5wEeujtxHNUqVz/vt0/hwWAOE=";
  };
  buildInputs = [ undmg ];

  sourceRoot = ".";
  installPhase = ''
    mkdir -p "$out/Applications"
    cp -r "Arc.app" "$out/Applications/Arc.app"
  '';

  meta = with lib; {
    homepage = arc.net;
    description = "Arc from The Browser Company";
    platforms = platforms.darwin;
  };
}
