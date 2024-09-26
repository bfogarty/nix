{ pkgs, ... }:

let
  darwin = import ./lib/darwin.nix { };

in
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
  ];

  time.timeZone = "America/New_York";

  nix.gc = {
    automatic = true;
    interval = { Weekday = 1; Hour = 0; Minute = 0; };  # Monday 00:00
    options = "--delete-older-than 30d";
  };

  nix.settings = {
    substituters = [
      "https://cache.nixos.org/"
      "https://bfogarty.cachix.org"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "bfogarty.cachix.org-1:Q44G+kZZesKfq1fMRcFezSt846t5zgQpiDFHTcvrI80="
    ];
    extra-experimental-features = "nix-command flakes";
  };

  # Enable (and auto upgrade) the nix daemon, used by multiuser installs.
  #   https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-daemon.html
  services.nix-daemon.enable = true;

  nixpkgs.config = (import home/nixpkgs-config.nix);

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  programs.fish.enable = true;

  # changes here require running `killall Dock` to take effect
  system.defaults.dock = {
    # don't rearrange spaces based on MRU
    mru-spaces = false;

    # show only open applications in the dock
    static-only = true;

    autohide = true;
    tilesize = 32;
  };

  # disable period with double-space
  system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;

  # disable default hotkeys
  system.activationScripts.extraUserActivation.text = darwin.disableHotkeys [
    darwin.hotkeys.spotlight
  ];

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
