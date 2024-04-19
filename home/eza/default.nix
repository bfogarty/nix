{
  programs.eza = {
    enable = true;

    git = true;

    extraOptions = [
      "--long"
      "--all"
      "--group-directories-first"
      "--git-ignore"
      "--no-permissions"
      "--no-user"
      "--no-time"
    ];
  };
}
