{ stdenv, lib, fetchurl, undmg }:

stdenv.mkDerivation rec {
  name = "arc";
  version = "0.102.0-38682";

  src = fetchurl {
    url = "https://releases.arc.net/release/Arc-${version}.dmg";
    sha256 = "sha256-Es75OKuQ4uHDvutyQaAMv5V/MpbzOMfItJer4SX+fII=";
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
