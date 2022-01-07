{ stdenv, lib, fetchurl, undmg, installShellFiles }:

stdenv.mkDerivation rec {
  name = "docker";

  src = fetchurl {
    url = "https://desktop.docker.com/mac/stable/Docker.dmg";
    sha256 = "028izydix9nsd6bwaf1555s7czapbr9qhi4gnydx802a99yslcym";
  };
  nativeBuildInputs = [ undmg installShellFiles ];

  sourceRoot = ".";
  installPhase = ''
    mkdir -p "$out/Applications"
    cp -r "Docker.app" "$out/Applications/Docker.app"

    installShellCompletion \
      --bash Docker.app/Contents/Resources/etc/docker.bash-completion \
      --fish Docker.app/Contents/Resources/etc/docker.fish-completion \
      --zsh  Docker.app/Contents/Resources/etc/docker.zsh-completion
    installShellCompletion \
      --bash Docker.app/Contents/Resources/etc/docker-compose.bash-completion \
      --fish Docker.app/Contents/Resources/etc/docker-compose.fish-completion \
      --zsh  Docker.app/Contents/Resources/etc/docker-compose.zsh-completion
  '';

  meta = with lib; {
    homepage = docker.com;
    description = "Accelerate how you build, share and run modern applications";
    platforms = platforms.darwin;
  };
}
