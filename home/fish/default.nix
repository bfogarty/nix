{ lib, pkgs, system, ... }:

{
  programs.fish = {
    enable = true;

    shellAbbrs = {
      dc = "docker-compose";
      g = "git";
    };

    shellAliases = {
      e = "stat .venv &> /dev/null; and poetry run $VISUAL; or $VISUAL";
      l = "ls -al";
      http = "http --style=vim";
      wip = "git add .;git commit -m 'WIP' --no-verify";
      unwip = "git reset --soft HEAD~1; git reset .";
      nix-shell = "nix-shell --run fish";
      docker-rm-stopped = "docker rm (docker ps -a -q)";
      docker-rm-images = "docker rmi (docker images -q)";
      reset-poetry-env = "poetry env remove (poetry env list | cut -d ' ' -f 1)";
      kubectx = "kubectl config use-context (kubectl config get-contexts -o name | fzf --height ~5)";
    } // lib.optionalAttrs (lib.strings.hasSuffix "darwin" system) {
      nix-reload = "darwin-rebuild switch --flake $HOME/dev/nix#(scutil --get LocalHostName)";
      flushdns = "sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder";
    };

    shellInit = ''
      # https://github.com/LnL7/nix-darwin/issues/122#issuecomment-481445861
      for p in /run/current-system/sw/bin ~/.nix-profile/bin /nix/var/nix/profiles/default/bin
        if not contains $p $fish_user_paths
          set -g fish_user_paths $p $fish_user_paths
        end
      end

      set -x VISUAL vim
      set -x EDITOR "$VISUAL"

      set -x PATH $PATH $HOME/.bin

      # Thyme specific
      set -x PATH $PATH $HOME/dev/thymesaver/bin

      set -x FZF_DEFAULT_COMMAND 'rg --files --hidden -g "!.git"'

      complete -f -c workon -a "(__fish_workon_complete_projects)"
    '';

    interactiveShellInit = builtins.readFile ./prompt.fish;

    functions = {
      fish_greeting = {
        description = "Draw the fish shell logo";
        body = ''
          # Adapted from the function by @xfix on the following GitHub issue:
          # https://github.com/fish-shell/fish-shell/issues/114
          set c1 (set_color f00)
          set c2 (set_color ff7f00)
          set c3 (set_color ff0)

          echo '                 '$c1'___
          ___======____='$c2'-'$c3'-'$c2'-='$c1')
        /T            \_'$c3'--='$c2'=='$c1')
        [ \ '$c2'('$c3'0'$c2')   '$c1'\~    \_'$c3'-='$c2'='$c1')
         \      / )J'$c2'~~    '$c1'\\'$c3'-='$c1')
          \\\\___/  )JJ'$c2'~'$c3'~~   '$c1'\)
           \_____/JJJ'$c2'~~'$c3'~~    '$c1'\\
           '$c2'/ '$c1'\  '$c3', \\'$c1'J'$c2'~~~'$c3'~~     '$c2'\\
          (-'$c3'\)'$c1'\='$c2'|'$c3'\\\\\\'$c2'~~'$c3'~~       '$c2'L_'$c3'_
          '$c2'('$c1'\\'$c2'\\)  ('$c3'\\'$c2'\\\)'$c1'_           '$c3'\=='$c2'__
           '$c1'\V    '$c2'\\\\'$c1'\) =='$c2'=_____   '$c3'\\\\\\\\'$c2'\\\\
                  '$c1'\V)     \_) '$c2'\\\\'$c3'\\\\JJ\\'$c2'J\)
                              '$c1'/'$c2'J'$c3'\\'$c2'J'$c1'T\\'$c2'JJJ'$c1'J)
                              (J'$c2'JJ'$c1'| \UUU)
                               (UU)'(set_color normal)
        '';
      };
      git = {
        description = "Wrap git to prevent me from being a moron";
        wraps = "git";
        body = ''
          if [ "$argv[1]" = "reset" ]; and [ (string lower \"$argv[2]\") = \"--hard\" ]
               echo "Are you being a moron again?"
               read i
               if [ "$i" = "no" ]
                    command git $argv
               end

          else if [ "$argv[1]" = "remote" ]; or [ "$argv[1]" = "clone" ]
               set_color yellow
               echo "WARNING: Be sure to set the correct author."
               set_color normal
               command git $argv

          else
               command git $argv
          end
        '';
      };
      workon = {
        description = "Navigate to a subdirectory of ~/dev";
        body = "cd \"$HOME/dev/$argv[1]\"";
      };
      __fish_workon_complete_projects = ''
        find $HOME/dev -maxdepth 1 \( -type d -or -type l \) -exec basename {} \;
      '';
    };
  };
}
