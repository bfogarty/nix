{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;

    shell = "${pkgs.fish}/bin/fish";
    terminal = "tmux-256color";

    keyMode = "vi";
  };
}
