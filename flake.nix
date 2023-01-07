{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-22.11";

    # pinned package versions
    pkgs_kubectl_1_21_3.url = "github:nixos/nixpkgs?rev=b9acd426df4b1ae98da24f1a973968f83f5dcb19";

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
    sharedOverlays = [
      (import ./overlays/autoPatchElf.nix)
      (import ./overlays/shapely.nix)
    ];

  in {
    darwinConfigurations = {
      Thyme-M5772J33W1 = let
        username = "brianfogarty";
        hostname = "Thyme-M5772J33W1";
        system = "aarch64-darwin";

      in darwin.lib.darwinSystem {
        inherit system;

        modules = [
          # default darwin config
          ./darwin-configuration.nix

          # device-specific settings
          {
            networking.hostName = hostname;
            users.users = {
              ${username} = { home = "/Users/${username}"; };
            };
          }

          # home-manager module
          home-manager.darwinModules.home-manager {
            nixpkgs = {
              overlays = sharedOverlays ++ [
                # pin kubectl because max drift w/ server is +/-1 minor version
                (self: super: { kubectl = (import inputs.pkgs_kubectl_1_21_3 { inherit system; }).pkgs.kubectl; })
              ];
            };

            ##  TODO this removes home-manager from ~/.nix-profile
            # home-manager.useUserPackages = true;
            home-manager.useGlobalPkgs = true;
            home-manager.users.brianfogarty = import ./home;

            home-manager.extraSpecialArgs = {
              stable = (import inputs.nixpkgs-stable { inherit system; });
            };
          }
        ];
      };
    };
  };
}
