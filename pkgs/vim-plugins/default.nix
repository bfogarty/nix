{ pkgs, ... }:

# To get sha256:
#  nix-prefetch-url --unpack \
#  https://github.com/<owner>/<repo>/archive/<sha>.tar.gz

{
  vim-hcl = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "vim-hcl";
    version = "94fbd19";
    src = pkgs.fetchFromGitHub {
      owner = "jvirtanen";
      repo = "vim-hcl";
      rev = "94fbd199c8a947ede62f98509f91d637d7967454";
      sha256 = "0n2dmgfajji8nxxirb9q9jmqnzc1mjqnic5igs84pxmbc6r57zqq";
    };
    meta.homepage = "https://github.com/jvirtanen/vim-hcl";
  };

  vim-wordmotion = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "vim-hcl";
    version = "257a59c";
    src = pkgs.fetchFromGitHub {
      owner = "chaoren";
      repo = "vim-wordmotion";
      rev = "257a59c78857e76612c778b2eed2ef5c266f26bc";
      sha256 = "164i2sicl98vzdp6b1zg0m56lva09a21l55js1vgmw3d2vq7b8x7";
    };
    meta.homepage = "https://github.com/chaoren/vim-wordmotion";
  };

  # there is a nix pkg for this, but it hasn't been updated yet
  vim-latex-live-preview = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "vim-latex-live-preview";
    version = "afdf3f4";
    src = pkgs.fetchFromGitHub {
      owner = "xuhdev";
      repo = "vim-latex-live-preview";
      rev = "afdf3f4778119f0bfacb07629d0155d58eb5562a";
      sha256 = "0zihnphc021alqbn1f84n233r6a31n499046yw1yspkcnpz7mcxm";
    };
    meta.homepage = "https://github.com/xuhdev/vim-latex-live-preview";
  };
}
