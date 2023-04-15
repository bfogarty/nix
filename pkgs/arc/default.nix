{ stdenv, lib, fetchurl, undmg }:

stdenv.mkDerivation rec {
  name = "arc";
  version = "0.98.1-38290";

  src = fetchurl {
    url = "https://releases.arc.net/release/Arc-${version}.dmg";
    sha256 = "sha256-dba0ca6Y9CO6n0jLtWpXPIaWDZUgVjvkGNgCoRHP4NY=";
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
