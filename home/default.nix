{ pkgs, ... }:

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
    ./kitty
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
  ] ++ lib.optionals pkgs.hostPlatform.isDarwin [
    docker-for-mac
  ];

  nixpkgs.config = {
    allowUnfree = true;
  };
}
