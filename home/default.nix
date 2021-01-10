{ pkgs, ... }:

let
  mole = pkgs.callPackage ../pkgs/mole { };
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
    session-manager-plugin
    k9s
    kubectl
    postgresql # for psql
  ];
}
