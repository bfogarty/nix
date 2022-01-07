{ stdenv, lib, fetchurl, unzip }:

stdenv.mkDerivation rec {
  name = "terminal-notifier";
  version = "2.0.0";

  phases = [ "unpackPhase" "installPhase" ];

  src = fetchurl {
    url = "https://github.com/julienXX/${name}/releases/download/${version}/${name}-${version}.zip";
    sha256 = "033d6yrnq2ac863l1x2a0sqzh22i4hdr6f1m5jqss4lxjxypcvii";
  };
  buildInputs = [ unzip ];

  sourceRoot = ".";
  installPhase = ''
    mkdir -p "$out/Applications"
    cp -r "terminal-notifier.app" "$out/Applications/terminal-notifier.app"
  '';

  meta = with lib; {
    homepage = "https://github.com/julienXX/terminal-notifier";
    description = "Send User Notifications on macOS from the command-line.";
    platforms = platforms.darwin;
  };
}
