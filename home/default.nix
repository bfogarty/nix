{ pkgs, ... }:

let
  mole = pkgs.callPackage ../pkgs/mole { };
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
    fzf
    httpie
    mole
    python3
    pre-commit
    ripgrep
    awscli
    sentry-cli
    session-manager-plugin
    k9s
    kubectl
    postgresql # for psql
  ];
}
