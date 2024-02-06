self: super: {
  python311 = super.python311.override {
    packageOverrides = python-self: python-super: {
    };
  };
}
