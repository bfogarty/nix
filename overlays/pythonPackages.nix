self: super: {
  python310 = super.python310.override {
    packageOverrides = python-self: python-super: {
      aws-lambda-builders = python-super.aws-lambda-builders.overrideAttrs (oldAttrs: {
        patches = [
          # This patch can be removed once https://github.com/aws/aws-lambda-builders/pull/475 has been merged.
          (super.fetchpatch {
            name = "setuptools-66-support";
            url = "https://patch-diff.githubusercontent.com/raw/aws/aws-lambda-builders/pull/475.patch";
            sha256 = "sha256-EkYQ6DNzbSnvkOads0GFwpGzeuBoLVU42THlSZNOHMc=";
          })
        ];
      });
    };
  };
}
