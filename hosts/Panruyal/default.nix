{
  config-vars,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  dbConfig = {
    bluetooth = true;
    hyprland = true;
    steam = true;
  };

  # boot related configs
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
      configurationLimit = 10;
      timeoutStyle = "menu";
      # theme = pkgs.catppuccin-grub;
    };
    efi.canTouchEfiVariables = true;
  };

  # Enable graphic driver
  hardware = {
    graphics.enable = true;
  };

  networking.hostName = config-vars.hostname;
  system.stateVersion = config-vars.stateVersion;
}
