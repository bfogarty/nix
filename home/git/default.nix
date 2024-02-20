{ lib, pkgs, system, ... }:

{
  programs.git = {
    enable = true;

    userEmail = "brian@fogarty.email";
    userName = "Brian Fogarty";

    signing = {
      key = "2742DCAE6B6532EB0B3085291BF984D7BCEC49A5";
      signByDefault = true;
    };

    difftastic = {
      enable = true;
    };

    extraConfig = {
      pull.rebase = true;
      diff.colorMoved = "zebra";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };

    aliases = {
      s = "status -s";
      l = "log --graph --oneline";
      amend = "commit --amend";
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
    ] ++ lib.optionals (lib.strings.hasSuffix "darwin" system) [
      # macOS specific files
      ".DS_Store"
    ];
  };
}
