{ stdenv, fetchzip, unzip, python3 }:

stdenv.mkDerivation rec {
  pname = "session-manager-plugin";
  version = "1.2.7.0";

  phases = [ "unpackPhase" "installPhase" ];

  base_url = "https://s3.amazonaws.com/session-manager-downloads/plugin";
  docs_url = "https://docs.aws.amazon.com/systems-manager/${version}/userguide/";

  src =
    fetchzip rec {
      name = "sessionmanager-bundle.zip";
      url = "${base_url}/${version}/mac/${name}";
      sha256 = "1zall82dcpif70dwkhrn4jvjnrcsnq5r6z7bhgxd90kln4k9xz5x";
    };

  buildInputs = [ python3 ];

  installPhase = ''
    install -d $out/bin
    install -m755 bin/session-manager-plugin $out/bin/session-manager-plugin
  '';

  meta = with stdenv.lib; {
    description = "AWS Systems Manager Session Manager";
    longDescription = ''
      Session Manager is a fully managed AWS Systems Manager capability that
      lets you manage your Amazon EC2 instances, on-premises instances,
      and virtual machines (VMs).
    '';
    homepage = "${docs_url}/session-manager.html";
    changelog = "${docs_url}/session-manager-working-with-install-plugin.html#plugin-version-history";
    license = licenses.bsd3;
    platforms = platforms.darwin;
  };
}
