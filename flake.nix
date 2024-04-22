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

        extraModules = [{
          home-manager.users.${username} = {
            programs.git.includes = [{
              path = "${inputs.thymesaver}/dotfiles/.gitconfig";
            }];

            programs.fish.functions.thyme-dl = ''
              git clone "git@github.com:thymecare/$argv[1].git" "$HOME/dev/$argv[1]"
            '';

            launchd.agents.thymeauth = {
              enable = true;
              config = {
                ProgramArguments = [
                  "${inputs.thymesaver}/bin/thyme_packages_auth"
                ];
                EnvironmentVariables = {
                  PATH = let
                    dependencies = [ "awscli2" "poetry" "coreutils" ];
                  in
                    builtins.concatStringsSep
                      ":"
                      (map (x: "${nixpkgs.legacyPackages.${system}.${x}}/bin") dependencies);
                  AWS_PROFILE = "thyme-prod-engineering";
                };
                # every 6 hours (twice as often as required)
                StartInterval = 7200;
              };
            };
          };
        }];
      };
    };
  };
}
