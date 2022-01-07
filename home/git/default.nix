{ lib, pkgs, ... }:

{
  programs.git = {
    enable = true;

    userEmail = "brian@fogarty.email";
    userName = "Brian Fogarty";

    aliases = {
      s = "status -s";
      l = "log --graph --oneline";
      last = "diff HEAD~ HEAD";
      staged = "diff --staged";
    };

    ignores = [
      # project-specific vim configuration
      ".lvimrc"

      # vim swap files
      "*.sw*"

      # ctags files
      "tags"

      # nix shell configurations
      "shell.nix"

      # direnv
      ".envrc*"
      ".direnv"
    ] ++ lib.optionals pkgs.hostPlatform.isDarwin [
      # macOS specific files
      ".DS_Store"
    ];
  };
}
