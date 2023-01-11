self: super: {
  python310 = super.python310.override {
    packageOverrides = python-self: python-super: {
      shapely = python-super.shapely.overrideAttrs (oldAttrs: rec {
        pname = "Shapely";
        version = "1.8.4";

        src = python-super.fetchPypi {
          inherit pname version;
          sha256 = "sha256-oZXlHKr6IYKR8suqP+9p/TNTyT7EtlsqRyLEz0DDGYw=";
        };

        disabledTests = [
          "test_collection"
          "test_error_handler"
          "test_error_handler_exception"
          "test_info_handler"
        ];

        patches = builtins.elemAt oldAttrs.patches 0;
      });
    };
  };
}
