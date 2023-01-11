{
  programs.zellij = {
    enable = true;

    settings = {
      default_mode = "locked";

      keybinds = {
        unbind = [
          # clashes with vim bindings
          { "Ctrl" = "h"; }
        ];
        normal = [
          {
            "action" = [ { "SwitchToMode" = "Move"; } ];
            "key" = [ { "Ctrl" = "k"; } ];
          }
        ];
      };

      default_shell = "fish";
    };
  };
}
