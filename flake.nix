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
    globalOverlays = [
      ./overlays/autoPatchElf.nix
      ./overlays/shapely.nix
    ];

    mkDarwinSystem = {
      username,
      hostname,
      system,
      extraOverlays ? [],
    }: darwin.lib.darwinSystem {
      inherit system;

      modules = let
	# create global overlays outside of home-manager, for `nix-shell`, etc
        xdgOverlays = map (x: {
          home-manager.users.${username}.xdg.configFile."nixpkgs/overlays/${builtins.baseNameOf x}.nix".source = x;
	}) globalOverlays;

      in [
        # default darwin config module
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
            overlays = (map (x: import x) globalOverlays) ++ extraOverlays;
          };

          ##  TODO this removes home-manager from ~/.nix-profile
          # home-manager.useUserPackages = true;
          home-manager.useGlobalPkgs = true;
          home-manager.users.${username} = import ./home;

          home-manager.extraSpecialArgs = {
            inherit system;

            # provide the `stable` channel as an extra arg to home-manager
            stable = (import inputs.nixpkgs-stable { inherit system; config = (import ./home/nixpkgs-config.nix); });
          };
        }
      ] ++ xdgOverlays;
    };

  in {
    darwinConfigurations = {
      brian-mbp-2 = mkDarwinSystem {
        username = "brian";
        hostname = "brian-mbp-2";
        system = "x86_64-darwin";
      };

      Thyme-M5772J33W1 = mkDarwinSystem rec {
        username = "brianfogarty";
        hostname = "Thyme-M5772J33W1";
        system = "aarch64-darwin";
        extraOverlays = [
          # pin kubectl because max drift w/ server is +/-1 minor version
          (self: super: { kubectl = (import inputs.pkgs_kubectl_1_21_3 { inherit system; }).pkgs.kubectl; })
        ];
      };
    };
  };
}
