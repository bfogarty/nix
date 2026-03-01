{ lib, pkgs, system, ... }:

{
  programs.git = {
    enable = true;

    signing = {
      key = "2742DCAE6B6532EB0B3085291BF984D7BCEC49A5";
      signByDefault = true;
    };

    settings = {
      user = {
        name = "Brian Fogarty";
        email = "brian@fogarty.email";
      };

      aliases = {
        s = "status -s";
        l = "log --graph --oneline";
        amend = "commit --amend";
        last = "diff HEAD~ HEAD";
        staged = "diff --staged";
      };

      pull.rebase = true;
      diff.colorMoved = "zebra";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
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
    ] ++ lib.optionals (lib.strings.hasSuffix "darwin" system) [
      # macOS specific files
      ".DS_Store"
    ];
  };
}
