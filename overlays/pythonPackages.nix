self: super: {
  python310 = super.python310.override {
    packageOverrides = python-self: python-super: {
    };
  };
}
