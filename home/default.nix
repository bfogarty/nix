{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellInit = ''
      # https://github.com/LnL7/nix-darwin/issues/122#issuecomment-481445861
      for p in /run/current-system/sw/bin ~/.nix-profile/bin /nix/var/nix/profiles/default/bin
        if not contains $p $fish_user_paths
          set -g fish_user_paths $p $fish_user_paths
        end
      end
    '';
  };

  programs.git = {
    enable = true;
    userEmail = "bri@nfogarty.me";
    userName = "Brian Fogarty";
  };

  programs.kitty = {
    enable = true;
    settings = {
      shell = "/Users/brian/.nix-profile/bin/fish";
    };
  };

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
    ];
  };

  home.packages = with pkgs; [
    fzf
    httpie
    python3
    awscli
    k9s
    kubectl
    postgresql # for psql
  ];
}
