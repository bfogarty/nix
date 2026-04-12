{ pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty-bin;

    settings = {
      command = "${pkgs.fish}/bin/fish";
      working-directory = "home";
      window-inherit-working-directory = false;
    };
  };
}
