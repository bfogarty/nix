{ pkgs, lib, system, stable, ... }:

let
  # automatically call all packages in ../pkgs
  customPkgs = lib.attrsets.mapAttrs' (name: value: {
    inherit name;
    value = pkgs.callPackage (../pkgs + "/${name}") { };
  }) (builtins.readDir ../pkgs);

in {
  imports = [
    ./difftastic
    ./direnv
    ./eza
    ./fish
    ./ghostty
    ./git
    ./gpg
    # TODO: broken test: test_fish_integration
    # ./kitty
    ./alacritty
    ./tmux
    ./vim
    ./zellij
  ];

  home.packages = with pkgs // customPkgs; [
    arc
    # broken: bitwarden-cli
    stable.pkgs.nodePackages.aws-cdk
    awscli2
    nodePackages.cdk8s-cli
    ctags
    fzf
    gnumake
    httpie
    iam-policy-tf
    jq
    k9s
    kubectl
    kubernetes-helm
    # TODO helm-diff (installed via helm plugin install)
    obsidian
    pgcli
    postgresql_16 # for psql
    rectangle
    python313
    python313Packages.grip
    python313Packages.ipython
    (poetry.override { python3 = python313; })
    ripgrep
    sentry-cli
    session-manager-plugin
    inetutils  # telnet
    tree
    todoist
    raycast
    keybase
    openssl
    spotify
    nmap
  ] ++ lib.optionals (system == "x86_64-darwin") [
  ];

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  # nixpkgs config for home-manager is set by nix-darwin
  #
  # this also sets it outside home-manager (e.g., nix-shell)
  xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;

  home.stateVersion = "22.11";
}
