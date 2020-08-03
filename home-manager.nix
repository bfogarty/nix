{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userEmail = "bri@nfogarty.me";
    userName = "Brian Fogarty";
  };

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
    ];
  };

  home.packages = with pkgs; [
  ];
}
