self: super: {
  # python-poetry/poetry#5929
  poetry = super.poetry.overrideAttrs (old: {
    postInstall = let
      # 'xyz'' => "xyz"'
      match = "'([^']+)''";
      replace = "\"$1\"'";
    in ''
      installShellCompletion --cmd poetry \
        --bash <($out/bin/poetry completions bash) \
        --zsh <($out/bin/poetry completions zsh) \
        --fish <($out/bin/poetry completions fish | ${super.sd}/bin/sd "${match}" "${replace}")
    '';
  });
}
