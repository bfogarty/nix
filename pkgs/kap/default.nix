{ stdenv, lib, fetchurl, undmg }:

stdenv.mkDerivation rec {
  name = "kap";
  version = "3.3.2";

  phases = [ "unpackPhase" "installPhase" ];

  src = fetchurl {
    url = "https://github.com/wulkano/Kap/releases/download/v${version}/Kap-${version}.dmg";
    sha256 = "0ibw1d7dmkxx5nmil14gc0mci34dlzrzs03rn1xzdw18f760axrj";
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
