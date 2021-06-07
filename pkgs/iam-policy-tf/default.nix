{ stdenv, lib, fetchurl, autoPatchelfHook }:

stdenv.mkDerivation rec {
  repo = "iam-policy-json-to-terraform";

  name = "${repo}-${version}";
  version = "1.7.0";

  src = fetchurl {
    url = "https://github.com/flosell/${repo}/releases/download/${version}/${repo}_darwin";
    sha256 = "17md9qijkk5vhf8z7wi5jfs0c2nlrwnqsbai68cf42sxzv3lixmg";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  # disable unpackPhase; the binary isn't compressed
  dontUnpack = true;

  installPhase = ''
    install -d $out/bin
    install -m755 $src $out/bin/iam-policy-json-to-terraform
  '';

  meta = with lib; {
    homepage = "https://github.com/flosell/iam-policy-json-to-terraform";
    description = "Small tool to convert an IAM Policy in JSON format into a Terraform aws_iam_policy_document";
    license = licenses.asl20;
    platforms = platforms.darwin;
  };
}
