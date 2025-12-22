{
  config,
  config-vars,
  username,
  ...
}:
{
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    stateVersion = config-vars.stateVersion;

    pointerCursor = {
      hyprcursor.enable = true;
      size = 24;
    };
  };

  xdg.configFile."uwsm/env".source =
    "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";

  programs.home-manager.enable = true;

  # programs.git = {
  #   enable = true;
  #   settings = {
  #     user.name = "hyeondobin";
  #     user.email = "dobinhyeon@gmail.com";
  #     init = {
  #       defaultBranch = "main";
  #     };
  #   };
  # };

  catppuccin = {
    enable = true;
    accent = "sapphire";
    flavor = "macchiato";
    cursors = {
      enable = true;
    };
  };
}
