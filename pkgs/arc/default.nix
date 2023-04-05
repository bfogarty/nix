{ stdenv, lib, fetchurl, undmg }:

stdenv.mkDerivation rec {
  name = "arc";
  version = "0.96.0-38004";

  src = fetchurl {
    url = "https://releases.arc.net/release/Arc-${version}.dmg";
    sha256 = "sha256-KnFgyFfz1vZwOWAaJRg4AeGitlWN6WA5JnhIvM1m8Ek=";
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
