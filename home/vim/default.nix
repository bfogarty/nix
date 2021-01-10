{ pkgs, ...}:

let
  customVimPlugins = pkgs.callPackage ../../pkgs/vim-plugins { };

in {
  programs.vim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      # Util
      fzf-vim
      vim-localvimrc

      # UI
      nord-vim
      nerdtree
      lightline-vim

      # Code
      ale
      fugitive
      fugitive-gitlab-vim
      vim-surround
      vim-commentary
      vim-test
      customVimPlugins.vim-latex-live-preview
      customVimPlugins.vim-wordmotion

      # Syntax
      vim-nix
      vim-vue
      vim-javascript  # TODO needed?
      vim-ps1
      customVimPlugins.vim-hcl

      # Writing
      goyo-vim
      limelight-vim
    ];

    extraConfig = builtins.readFile ./.vimrc;
  };
}
