{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      font = {
        size = 13.0;
      };

      shell = {
        program = "/Users/brian/.nix-profile/bin/fish";
      };
    };

  };
}
