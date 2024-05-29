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
      dracula-vim
      lightline-vim
      vinegar

      # Code
      copilot-vim
      fugitive
      vim-rhubarb
      vim-surround
      vim-commentary
      vim-test
      customVimPlugins.vim-latex-live-preview
      customVimPlugins.vim-wordmotion
      splitjoin-vim

      # Syntax
      vim-nix
      vim-vue
      vim-javascript  # TODO needed?
      vim-ps1
      vim-helm
      vim-svelte
      customVimPlugins.vim-hcl
      customVimPlugins.lang
      vim-lsp
      customVimPlugins.vim-lsp-settings
      asyncomplete-vim
      asyncomplete-lsp-vim
      ultisnips
      customVimPlugins.snippets

      # Writing
      goyo-vim
      limelight-vim
    ];

    extraConfig = builtins.readFile ./.vimrc;
  };
}
