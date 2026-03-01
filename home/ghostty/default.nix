{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;

    settings = {
      command = "${pkgs.fish}/bin/fish";
    };
  };
}
