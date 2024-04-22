{ system, inputs, ... }:

{
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
            (map (x: "${inputs.nixpkgs.legacyPackages.${system}.${x}}/bin") dependencies);
        AWS_PROFILE = "thyme-prod-engineering";
      };
      # every 6 hours (twice as often as required)
      StartInterval = 7200;
    };
  };
}
