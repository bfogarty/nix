{ stdenv, lib, fetchurl, undmg }:

stdenv.mkDerivation rec {
  name = "kap";
  version = "3.5.1";

  src = fetchurl {
    url = "https://github.com/wulkano/Kap/releases/download/v${version}/Kap-${version}.dmg";
    sha256 = "jpPX++MOnCtL2gB4zKXo+UulwenKCxuZEFTZ8iJ8vxs=";
  };
  buildInputs = [ undmg ];

  sourceRoot = ".";
  installPhase = ''
    mkdir -p "$out/Applications"
    cp -r "Kap.app" "$out/Applications/Kap.app"
  '';

  meta = with lib; {
    homepage = getkap.co;
    description = "An open-source screen recorder built with web technology";
    platforms = platforms.darwin;
  };
}
