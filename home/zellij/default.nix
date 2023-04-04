{
  programs.zellij = {
    enable = true;

    settings = {
      default_mode = "locked";

      keybinds = {
        # clashes with vim bindings
        unbind = "Ctrl h";

        normal = {
          bind = {
            _args = [ "Ctrl k" ];
            SwitchToMode = "Move";
          };
        };
      };

      default_shell = "fish";
    };
  };
}
