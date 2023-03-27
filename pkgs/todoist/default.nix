{ stdenv, lib, fetchurl, undmg }:

stdenv.mkDerivation rec {
  name = "todoist";
  version = "8.1.2";

  src = fetchurl {
    url = "https://electron-dl.todoist.com/mac/Todoist-${version}.dmg";
    sha256 = "7EpAdwiFC2EF3KIdTdh6lyLtRy0HvyWrAGDTb7oplAI=";
  };
  buildInputs = [ undmg ];

  sourceRoot = ".";
  installPhase = ''
    mkdir -p "$out/Applications"
    cp -r "Todoist.app" "$out/Applications/Todoist.app"
  '';

  meta = with lib; {
    homepage = https://todoist.com/;
    description = "A To-Do List to Organize Your Work & Life";
    platforms = platforms.darwin;
  };
}
