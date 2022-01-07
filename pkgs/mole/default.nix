{ stdenv, lib, fetchurl, autoPatchelfHook }:

stdenv.mkDerivation rec {
  name = "mole-${version}";
  version = "0.5.0";

  src = fetchurl {
    url = "https://github.com/davrodpin/mole/releases/download/v${version}/mole${version}.darwin-amd64.tar.gz";
    sha256 = "618e29266e4fd42bfbbe9c3b9c030a656f1a24344d7148928f3f71b8bdef9ab3";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  unpackPhase = ''
    tar -xzf $src
  '';

  installPhase = ''
    install -d $out/bin
    install -m755 mole $out/bin/mole
  '';

  meta = with lib; {
    homepage = https://davrodpin.github.io/mole/;
    description = "Easily create SSH tunnels.";
    license = licenses.mit;
    platforms = platforms.darwin;
  };
}
