{ stdenv, fetchurl, autoPatchelfHook }:

stdenv.mkDerivation rec {
  name = "sentry-cli";
  version = "1.59.0";

  src = fetchurl {
    url = "https://github.com/getsentry/sentry-cli/releases/download/v${version}/sentry-cli-Darwin-x86_64";
    sha256 = "0m2rl0290z2drh3psni1hvdycnfs2fskg9ak3jic7g9p044iwjzn";
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
