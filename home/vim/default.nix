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
      vim-helm
      customVimPlugins.vim-hcl
      customVimPlugins.lang
      vim-lsp
      customVimPlugins.vim-lsp-settings
      asyncomplete-vim
      asyncomplete-lsp-vim

      # Writing
      goyo-vim
      limelight-vim
    ];

    extraConfig = builtins.readFile ./.vimrc;
  };
}
