{ stdenv, lib, fetchurl, undmg }:

stdenv.mkDerivation rec {
  name = "arc";
  version = "1.57.2-53036";

  src = fetchurl {
    url = "https://releases.arc.net/release/Arc-${version}.dmg";
    sha256 = "sha256-dQmuwCYqyuECXG3Z6BSHhfnlAl2ZFUa4uAbf+41dARk=";
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
