{ pkgs, ... }:

{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
  ];

  time.timeZone = "America/Chicago";

  nix.settings = {
    extra-experimental-features = "nix-command flakes";
  };

  # Enable (and auto upgrade) the nix daemon, used by multiuser installs.
  #   https://nixos.org/manual/nix/stable/command-ref/new-cli/nix3-daemon.html
  services.nix-daemon.enable = true;

  nixpkgs.config = (import home/nixpkgs-config.nix);

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  programs.fish.enable = true;

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

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
