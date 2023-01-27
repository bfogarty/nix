 self: super: {
   nodePackages.cdk8s-cli = super.nodePackages.cdk8s-cli.overrideAttrs (old: {
     # During `cdk8s import`, jsii-srcmak copies node_modules from the nix
     # store to a temp folder.  Since these files are readonly, trying to
     # remove the temp folder causes a permission denied. We can work around
     # this by patching cdk8s-cli to simply leave the temp folder.
     postInstall = ''
       substituteInPlace $out/lib/node_modules/cdk8s-cli/lib/util.js \
         --replace 'await fs.remove(workdir);' 'return;'
     '';
   });
 }
