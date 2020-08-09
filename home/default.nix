{ pkgs, ... }:

{
  imports = [
    ./fish
    ./git
    ./kitty
  ];

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
    ];
  };

  home.packages = with pkgs; [
    fzf
    httpie
    python3
    awscli
    k9s
    kubectl
    postgresql # for psql
  ];
}
