{ pkgs, ... }:

let
  android-studio = pkgs.callPackage ../pkgs/android-studio { };
  kap = pkgs.callPackage ../pkgs/kap { };
  mole = pkgs.callPackage ../pkgs/mole { };
  rectangle = pkgs.callPackage ../pkgs/rectangle { };
  sentry-cli = pkgs.callPackage ../pkgs/sentry-cli { };
  session-manager-plugin = pkgs.callPackage ../pkgs/session-manager-plugin { };

in {
  imports = [
    ./fish
    ./git
    ./kitty
    ./vim
  ];

  home.packages = with pkgs; [
    android-studio
    kap
    rectangle
    fzf
    python38Packages.grip
    python38Packages.ipython
    httpie
    mole
    python3
    ripgrep
    awscli
    sentry-cli
    session-manager-plugin
    k9s
    kubectl
    postgresql # for psql
    slack
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };
}
