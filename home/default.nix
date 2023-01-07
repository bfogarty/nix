{ pkgs, stdenv, stable, ... }:

let
  android-studio = pkgs.callPackage ../pkgs/android-studio { };
  docker-for-mac = pkgs.callPackage ../pkgs/docker-for-mac { };
  iam-policy-tf = pkgs.callPackage ../pkgs/iam-policy-tf { };
  kap = pkgs.callPackage ../pkgs/kap { };
  mole = pkgs.callPackage ../pkgs/mole { };
  rectangle = pkgs.callPackage ../pkgs/rectangle { };
  sentry-cli = pkgs.callPackage ../pkgs/sentry-cli { };
  session-manager-plugin = pkgs.callPackage ../pkgs/session-manager-plugin { };
  terminal-notifier = pkgs.callPackage ../pkgs/terminal-notifier { };

in {
  imports = [
    ./fish
    ./git
    # TODO: broken test: test_fish_integration
    # ./kitty
    ./alacritty
    ./tmux
    ./vim
  ];

  home.packages = with pkgs; [
    android-studio
    awscli2
    ctags
    direnv
    fzf
    gnumake
    httpie
    iam-policy-tf
    jq
    k9s
    kap
    kubectl
    kubernetes-helm
    # TODO helm-diff (installed via helm plugin install)
    mole
    pgcli
    postgresql_12 # for psql
    python39
    python39Packages.grip
    python39Packages.ipython
    rectangle
    ripgrep
    sentry-cli
    session-manager-plugin
    slack
    inetutils  # telnet
    terminal-notifier
    tree
  ];
  ## TODO: isDarwin is impure
  # ++ lib.optionals (pkgs.stdenv.isDarwin && pkgs.stdenv.isx86_64) [
  #  docker-for-mac
  #];

  # nixpkgs config for home-manager is set by nix-darwin
  #
  # this also sets it outside home-manager (e.g., nix-shell)
  xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;

  # this adds the autoPatchElf overlay outside of home-manager
  xdg.configFile."nixpkgs/overlays/autoPatchElf.nix".source = ../overlays/autoPatchElf.nix;

  home.stateVersion = "22.11";
}
