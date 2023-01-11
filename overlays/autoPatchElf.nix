self: super:
{
  autoPatchelfHook =
    super.pkgs.runCommand "auto-patchelf-hook" {} ''
      mkdir -p $out/nix-support
      echo "echo Skipping autoPatchelfHook..." > $out/nix-support/setup-hook
    '';
}
