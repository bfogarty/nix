{ pkgs, ... }:

let
  mole = pkgs.callPackage ../pkgs/mole { };

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
    k9s
    kubectl
    postgresql # for psql
  ];
}
