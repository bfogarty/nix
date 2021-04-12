{ ... }:

let
  hostname = "brian-thyme-mbp";

in {
  imports = [
    ../darwin-configuration.nix
  ];

  networking.hostName = hostname;

  environment.darwinConfig = "$HOME/dev/nix/hosts/${hostname}.nix";
}
