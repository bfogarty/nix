{ pkgs, system, stable, ... }:

let
  android-studio = pkgs.callPackage ../pkgs/android-studio { };
  docker-for-mac = pkgs.callPackage ../pkgs/docker-for-mac { };
  iam-policy-tf = pkgs.callPackage ../pkgs/iam-policy-tf { };
  kap = pkgs.callPackage ../pkgs/kap { };
  mole = pkgs.callPackage ../pkgs/mole { };
  rectangle = pkgs.callPackage ../pkgs/rectangle { };
  sentry-cli = pkgs.callPackage ../pkgs/sentry-cli { };
  session-manager-plugin = pkgs.callPackage ../pkgs/session-manager-plugin { };

in {
  imports = [
    ./direnv
    ./fish
    ./git
    # TODO: broken test: test_fish_integration
    # ./kitty
    ./alacritty
    ./tmux
    ./vim
    ./zellij
  ];

  home.packages = with pkgs; [
    stable.pkgs.nodePackages.aws-cdk
    android-studio
    awscli2
    nodePackages.cdk8s-cli
    ctags
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
    obsidian
    pgcli
    postgresql_12 # for psql
    python310
    python310Packages.grip
    python310Packages.ipython
    stable.poetry
    rectangle
    ripgrep
    sentry-cli
    session-manager-plugin
    slack
    inetutils  # telnet
    tree
  ] ++ lib.optionals (system == "x86_64-darwin") [
    docker-for-mac
  ];

  # nixpkgs config for home-manager is set by nix-darwin
  #
  # this also sets it outside home-manager (e.g., nix-shell)
  xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;

  home.stateVersion = "22.11";
}
