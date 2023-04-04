{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;

    settings = {
      font = {
        size = 15.0;
      };

      key_bindings = [
        # unlike kitty, alacritty has no darwin "option as meta" setting
        # https://github.com/alacritty/alacritty/issues/62
        {
          key = "E";
          mods = "Alt";
          chars = "\\x1be";
        }
        # for zellij
        { key = "H"; mods = "Alt"; chars = "\\x1bh"; }
        { key = "J"; mods = "Alt"; chars = "\\x1bj"; }
        { key = "K"; mods = "Alt"; chars = "\\x1bk"; }
        { key = "L"; mods = "Alt"; chars = "\\x1bl"; }
        { key = "N"; mods = "Alt"; chars = "\\x1bn"; }
      ];

      shell = {
        program = "${pkgs.fish}/bin/fish";
        args = [
          "-c"
          # on startup, join or create the zellij session "dev"
          "${pkgs.zellij}/bin/zellij a --create dev"
        ];
      };
    };

  };
}
