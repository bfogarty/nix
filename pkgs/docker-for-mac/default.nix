{ stdenv, lib, fetchurl, undmg, installShellFiles }:

stdenv.mkDerivation rec {
  name = "docker";

  src = fetchurl {
    url = "https://desktop.docker.com/mac/stable/Docker.dmg";
    sha256 = "GUu1nHAV3epoCZO+Qu5XLM0afkt/jwApP6OYuY8pJqo=";
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
    broken = true;
    platforms = ["x86_64-darwin"];
  };
}
