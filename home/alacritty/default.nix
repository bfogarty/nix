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
        {
          key = "V";
          mods = "Alt";
          chars = "\\x1bv";
        }
        # for zellij
        { key = "H"; mods = "Alt"; chars = "\\x1bh"; }
        { key = "J"; mods = "Alt"; chars = "\\x1bj"; }
        { key = "K"; mods = "Alt"; chars = "\\x1bk"; }
        { key = "L"; mods = "Alt"; chars = "\\x1bl"; }
        { key = "N"; mods = "Alt"; chars = "\\x1bn"; }
      ];

      # https://github.com/nordtheme/alacritty/blob/main/src/nord.yaml
      colors = {
        primary = {
          background = "#2e3440";
          foreground = "#d8dee9";
          dim_foreground = "#a5abb6";
        };
        cursor = {
          text = "#2e3440";
          cursor = "#d8dee9";
        };
        vi_mode_cursor = {
          text = "#2e3440";
          cursor = "#d8dee9";
        };
        selection = {
          text = "CellForeground";
          background = "#4c566a";
        };
        search = {
          matches = {
            foreground = "CellBackground";
            background = "#88c0d0";
          };
        };
        footer_bar = {
          background = "#434c5e";
          foreground = "#d8dee9";
        };
        normal = {
          black = "#3b4252";
          red = "#bf616a";
          green = "#a3be8c";
          yellow = "#ebcb8b";
          blue = "#81a1c1";
          magenta = "#b48ead";
          cyan = "#88c0d0";
          white = "#e5e9f0";
        };
        bright = {
          black = "#4c566a";
          red = "#bf616a";
          green = "#a3be8c";
          yellow = "#ebcb8b";
          blue = "#81a1c1";
          magenta = "#b48ead";
          cyan = "#8fbcbb";
          white = "#eceff4";
        };
        dim = {
          black = "#373e4d";
          red = "#94545d";
          green = "#809575";
          yellow = "#b29e75";
          blue = "#68809a";
          magenta = "#8c738c";
          cyan = "#6d96a5";
          white = "#aeb3bb";
        };
      };

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
