{ home-manager, darwin, nixpkgs-stable, ... }:

{
  # makes an overlay that replaces a package with the version from `pkgs`
  #
  # useful for pinning a package to the version available in a particular
  # nixpkgs revision: https://lazamar.co.uk/nix-versions/
  #
  # usage:
  #   mkPinOverlay {
  #     name = "kubectl";
  #     system = "x86_64-darwin"; 
  #     pkgs = (builtins.fetchTarball { url = "..." });
  #   }
  mkPinOverlay = {
    name,
    system,
    pkgs,
  }: (self: super: {
    ${name} = (import pkgs { inherit system; }).pkgs.${name};
  });

  # makes a nix-darwin system configuration
  #
  # specifically:
  #   - applies some global overlays to home-manager and nixpkgs
  #   - sets device-specific settings (username, hostname)
  #   - applies the global darwin config, ../darwin-configuration.nix
  #   - applies the home-manager config ../home
  #
  # usage:
  #   mkDarwinSystem {
  #     username = "...";
  #     hostname = "...";
  #     system = "x86_64-darwin"; 
  # 
  #     extraOverlays = [(self: super: { ... })];
  #   }
  mkDarwinSystem = {
    username,
    hostname,
    system,

    # extra nixpkgs overlays to apply to home-manager
    extraOverlays ? [],

    # extra modules to merge with this config, allows host-specific settings
    extraHomeManager ? {},
  }: darwin.lib.darwinSystem {
    inherit system;

    modules = let
      globalOverlays = [
        ../overlays/autoPatchElf.nix
        ../overlays/cdk8s.nix
        ../overlays/pythonPackages.nix
        ../overlays/poetry.nix
      ];

      # create global overlays outside of home-manager, for `nix-shell`, etc
      xdgOverlays = map (x: {
        home-manager.users.${username}.xdg.configFile."nixpkgs/overlays/${builtins.baseNameOf x}.nix".source = x;
      }) globalOverlays;

    in [
      # default darwin config module
      ../darwin-configuration.nix

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
        home-manager.users.${username} = (import ../home) // extraHomeManager;

        home-manager.extraSpecialArgs = {
          inherit system;

          # provide the `stable` channel as an extra arg to home-manager
          stable = (import nixpkgs-stable {
            inherit system;
            config = (import ../home/nixpkgs-config.nix);
          });
        };
      }
    ] ++ xdgOverlays;
  };
}
