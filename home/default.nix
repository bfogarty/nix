{ pkgs, lib, system, stable, ... }:

let
  # automatically call all packages in ../pkgs
  customPkgs = lib.attrsets.mapAttrs' (name: value: {
    inherit name;
    value = pkgs.callPackage (../pkgs + "/${name}") { };
  }) (builtins.readDir ../pkgs);

in {
  imports = [
    ./direnv
    ./eza
    ./fish
    ./git
    # TODO: broken test: test_fish_integration
    # ./kitty
    ./alacritty
    ./tmux
    ./vim
    ./zellij
  ];

  home.packages = with pkgs // customPkgs; [
    arc
    bitwarden-cli
    stable.pkgs.nodePackages.aws-cdk
    android-studio
    awscli2
    nodePackages.cdk8s-cli
    ctags
    fzf
    gnumake
    gnupg
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
    python311
    python311Packages.grip
    python311Packages.ipython
    poetry
    rectangle
    ripgrep
    sentry-cli
    session-manager-plugin
    inetutils  # telnet
    tree
    todoist
    raycast
    keybase
    spotify
    nmap
  ] ++ lib.optionals (system == "x86_64-darwin") [
  ];

  # nixpkgs config for home-manager is set by nix-darwin
  #
  # this also sets it outside home-manager (e.g., nix-shell)
  xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;

  home.stateVersion = "22.11";
}
