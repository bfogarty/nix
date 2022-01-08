{ stdenv, lib, fetchurl, undmg }:

stdenv.mkDerivation rec {
  name = "android-studio";
  version = "4.1.1.0";
  build = "201.6953283";

  src = fetchurl {
    url = "https://redirector.gvt1.com/edgedl/android/studio/install/${version}/android-studio-ide-${build}-mac.dmg";
    sha256 = "1hzd8a0c1cm0r8z1h3pa3cgz73vxcl9d8y18mbf115nslgrjdjp9";
  };
  buildInputs = [ undmg ];

  sourceRoot = ".";
  installPhase = ''
    mkdir -p "$out/Applications"
    cp -r "Android Studio.app" "$out/Applications/Android Studio.app"
  '';

  meta = with lib; {
    homepage = https://developer.android.com/studio;
    description = "Android Studio provides the fastest tools for building apps on every type of Android device.";
    platforms = platforms.darwin;
  };
}
