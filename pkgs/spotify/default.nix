{ stdenv, lib, fetchurl, undmg }:

stdenv.mkDerivation rec {
  name = "spotify";
  version = "10.11-12";

  src = fetchurl {
    url = "https://download.scdn.co/Spotify-${version}.dmg";
    sha256 = "sha256-MaccPahtgZlVoSkD9kBKR0SKHucR5+QpdKZ+/2+2uSg=";
  };
  buildInputs = [ undmg ];

  sourceRoot = ".";
  installPhase = ''
    mkdir -p "$out/Applications"
    cp -r "Spotify.app" "$out/Applications/Spotify.app"
  '';

  meta = with lib; {
    homepage = spotify.com;
    description = "Music for everyone";
    platforms = platforms.darwin;
  };
}
