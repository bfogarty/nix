{
  programs.eza = {
    enable = true;

    git = true;

    extraOptions = [
      "--long"
      "--all"
      "--group-directories-first"
      "--no-permissions"
      "--no-user"
      "--no-time"
    ];
  };
}
