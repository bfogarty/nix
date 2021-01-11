{ stdenv, fetchurl, autoPatchelfHook }:

stdenv.mkDerivation rec {
  name = "sentry-cli";
  version = "1.61.0";

  src = fetchurl {
    url = "https://github.com/getsentry/sentry-cli/releases/download/${version}/sentry-cli-Darwin-x86_64";
    sha256 = "19x48l3xdwrv8rv4bwjaga6ra0g8s827hy79fayfsdjf2yq3fc6a";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  # disable unpackPhase; the binary isn't compressed
  dontUnpack = true;

  installPhase = ''
    install -d $out/bin
    install -m755 $src $out/bin/sentry-cli
  '';

  meta = with stdenv.lib; {
    homepage = https://github.com/getsentry/sentry-cli;
    description = "A command line utility to work with Sentry.";
    license = licenses.bsd3;
    platforms = platforms.darwin;
  };
}
