{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-22.11";

    # private repo - flake inputs are retrieved lazily so this won't
    # error on machines that don't have access if unused
    thymesaver = {
      url = "git+ssh://git@github.com/thymecare/thymesaver?ref=main";
      flake = false;
    };

    # pinned package versions
    pkgs_kubectl_1_28_4.url = "github:nixos/nixpkgs?rev=ffb4d9542a9fab7cc5fe34fdaa5378d398ab3a99";

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, darwin, ... }: let
    mkSystem = import ./lib/mkSystem.nix inputs;

  in {
    darwinConfigurations = {
      brian-mbp-2 = mkSystem.mkDarwinSystem {
        username = "brian";
        hostname = "brian-mbp-2";
        system = "x86_64-darwin";
      };

      Thyme-M5772J33W1 = mkSystem.mkDarwinSystem rec {
        username = "brianfogarty";
        hostname = "Thyme-M5772J33W1";
        system = "aarch64-darwin";

        extraOverlays = [
          # pin kubectl because max drift w/ server is +/-1 minor version
          (mkSystem.mkPinOverlay {
            inherit system;
            name = "kubectl";
            pkgs = inputs.pkgs_kubectl_1_28_4;
          })
        ];

        extraHomeManager = (import hosts/ThymeM5772J33W1.nix {
          inherit system inputs;
        });
      };
    };
  };
}
