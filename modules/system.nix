{
  pkgs,
  username,
  inputs,
  ...
}:
{
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
  nix.settings.trusted-users = [ username ];
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [
      "https://cache.nixos.org"
      "https://hyprland.cachix.org"
    ];
    trusted-substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
    builders-use-substitutes = true;
  };
  # nix.gc = {
  #   automatic = lib.mkDefault true;
  #   dates = lib.mkDefault "weekly";
  #   options = lib.mkDefault "--delete-older-than 7d";
  # };

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # nix cli wrapper
  programs.nh = {
    enable = true;
    flake = "/home/hyeondobin/repo/dobinix";
    clean = {
      enable = true;
      extraArgs = "--keep 3 --keep-since 4d";
    };
  };

  # login with dm
  # services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    # theme = "catppuccin-macchiato";
  };

  # time zone
  time.timeZone = "Asia/Seoul";
  time.hardwareClockInLocalTime = true;

  # Internationalisation
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ko_KR.UTF-8";
    LC_IDENTIFICATION = "ko_KR.UTF-8";
    LC_MEASUREMENT = "ko_KR.UTF-8";
    LC_MONETARY = "ko_KR.UTF-8";
    LC_NAME = "ko_KR.UTF-8";
    LC_NUMERIC = "ko_KR.UTF-8";
    LC_PAPER = "ko_KR.UTF-8";
    LC_TELEPHONE = "ko_KR.UTF-8";
    LC_TIME = "ko_KR.UTF-8";
  };

  # input method
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      addons = with pkgs; [
        fcitx5-hangul
        fcitx5-gtk
      ];
      settings = {
        inputMethod = {
          GroupOrder."0" = "Default";
          "Groups/0" = {
            Name = "Default";
            "Default Layout" = "us";
            DefaultIM = "hangul";
          };
          "Groups/0/Items/0".Name = "keyboard-us";
          "Groups/0/Items/1".Name = "hangul";
        };
        globalOptions = {
          Hotkey = {
            EnumerateWithTriggerKeys = true;
            EnumerateSkipFirst = false;
            ModifierOnlyKeyTimeout = "250";
          };
          "Hotkey/TriggerKeys"."0" = "Alt+Alt_R";
          "Hotkey/TriggerKeys"."1" = "Hangul";
        };
      };
    };
  };
  programs.git = {
    enable = true;
    config = {
      user.name = "hyeondobin";
      user.email = "dobinhyeon@gmail.com";
      init = {
        defaultBranch = "main";
      };
    };
  };

  # internet
  networking.networkmanager.enable = true;

  # touchpad
  services.libinput.enable = true;

  # Sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # init fish with bash
  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]] then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
    enable = true;
  };

  # font
  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.nerd-fonts.d2coding
  ];

  environment = {
    variables = {
      EDITOR = "nvim";
      SSH_AUTH_SOCK = "/home/${username}/.bitwarden-ssh-agent.sock";
    };
    systemPackages = with pkgs; [
      inputs.nxim.packages.${stdenv.hostPlatform.system}.nxim
      # inputs.nxim.packages.${stdenv.hostPlatform.system}.regularCats
      wget
      curl
      wl-clipboard
      kitty
      ghostty
      bat
      zoxide
      lazygit
      vivaldi
      bitwarden-desktop
      (catppuccin-sddm.override {
        flavor = "macchiato";
        fontSize = "12";
      })
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
  };
  catppuccin = {
    enable = true;
    accent = "sapphire";
    flavor = "macchiato";
    cursors = {
      enable = true;
    };
  };
}
