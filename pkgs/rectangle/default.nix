{ stdenv, lib, fetchurl, undmg }:

stdenv.mkDerivation rec {
  name = "rectangle";
  version = "0.40";

  phases = [ "unpackPhase" "installPhase" ];

  src = fetchurl {
    url = "https://github.com/rxhanson/Rectangle/releases/download/v${version}/Rectangle${version}.dmg";
    sha256 = "0gix3jibl4zijgffhyq7d1g2x38393fr9z1zbf6m7q0jsm8h7bbh";
  };
  buildInputs = [ undmg ];

  sourceRoot = ".";
  installPhase = ''
    mkdir -p "$out/Applications"
    cp -r "Rectangle.app" "$out/Applications/Rectangle.app"
  '';

  meta = with lib; {
    homepage = rectangleapp.com;
    description = "Rectangle is a window management app based on Spectacle.";
    platforms = platforms.darwin;
  };
}
