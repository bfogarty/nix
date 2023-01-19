self: super: {
  git = super.git.overrideAttrs (old: {
    src = super.fetchurl {
      url = "https://www.kernel.org/pub/software/scm/git/git-2.39.1.tar.xz";
      sha256 = "sha256-QKOKCEezDDcbNYc7OvzxI4hd1B6j7Lv1EO+pfzzlwWE=";
    };
  });
}
