{
  programs.kitty = {
    enable = true;

    settings = {
      font_size = "13.0";
      enabled_layouts = "grid";
      shell = "/Users/brian/.nix-profile/bin/fish";
      macos_option_as_alt = "yes";
      confirm_os_window_close = 1;
      enable_audio_bell = "no";
    };

    keybindings = {
      "ctrl+alt+enter" = "launch --cwd=current";
    };
  };
}
