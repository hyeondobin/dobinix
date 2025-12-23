{ inputs, pkgs, ... }:
{
  home.sessionVariables = {
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    settings = {
      ########################
      # Catppuccin Macchiato #
      ########################

      "$rosewater" = "rgb(f4dbd6)";
      "$rosewaterAlpha" = "f4dbd6";

      "$flamingo" = "rgb(f0c6c6)";
      "$flamingoAlpha" = "f0c6c6";

      "$pink" = "rgb(f5bde6)";
      "$pinkAlpha" = "f5bde6";

      "$mauve" = "rgb(c6a0f6)";
      "$mauveAlpha" = "c6a0f6";

      "$red" = "rgb(ed8796)";
      "$redAlpha" = "ed8796";

      "$maroon" = "rgb(ee99a0)";
      "$maroonAlpha" = "ee99a0";

      "$peach" = "rgb(f5a97f)";
      "$peachAlpha" = "f5a97f";

      "$yellow" = "rgb(eed49f)";
      "$yellowAlpha" = "eed49f";

      "$green" = "rgb(a6da95)";
      "$greenAlpha" = "a6da95";

      "$teal" = "rgb(8bd5ca)";
      "$tealAlpha" = "8bd5ca";

      "$sky" = "rgb(91d7e3)";
      "$skyAlpha" = "91d7e3";

      "$sapphire" = "rgb(7dc4e4)";
      "$sapphireAlpha" = "7dc4e4";

      "$blue" = "rgb(8aadf4)";
      "$blueAlpha" = "8aadf4";

      "$lavender" = "rgb(b7bdf8)";
      "$lavenderAlpha" = "b7bdf8";

      "$text" = "rgb(cad3f5)";
      "$textAlpha" = "cad3f5";

      "$subtext1" = "rgb(b8c0e0)";
      "$subtext1Alpha" = "b8c0e0";

      "$subtext0" = "rgb(a5adcb)";
      "$subtext0Alpha" = "a5adcb";

      "$overlay2" = "rgb(939ab7)";
      "$overlay2Alpha" = "939ab7";

      "$overlay1" = "rgb(8087a2)";
      "$overlay1Alpha" = "8087a2";

      "$overlay0" = "rgb(6e738d)";
      "$overlay0Alpha" = "6e738d";

      "$surface2" = "rgb(5b6078)";
      "$surface2Alpha" = "5b6078";

      "$surface1" = "rgb(494d64)";
      "$surface1Alpha" = "494d64";

      "$surface0" = "rgb(363a4f)";
      "$surface0Alpha" = "363a4f";

      "$base" = "rgb(24273a)";
      "$baseAlpha" = "24273a";

      "$mantle" = "rgb(1e2030)";
      "$mantleAlpha" = "1e2030";

      "$crust" = "rgb(181926)";
      "$crustAlpha" = "181926";

      ################
      ### MONITORS ###
      ################
      "$scale" = 1;
      monitor = ", preferred, auto, $scale";

      ##################
      ###  VARIABLES ###
      ##################
      "$mainMod" = "SUPER";
      "$shiftMod" = "SUPER SHIFT";
      "$ctrlMod" = "SUPER CTRL";
      "$altMod" = "SUPER ALT";
      "$hyprMod" = "SUPER SHIFT CTRL ALT";
      "$terminal" = "ghostty";
      "$emacs" = "emacs";
      # ref: https://www.reddit.com/r/wayland/comments/1cywhh2/anyone_still_seeing_flickering_in/
      "$webBrowser" = "vivaldi --disable-gpu";
      "$bitwarden" = "bitwarden";
      "$chrome" = "googel-chrome-stable --disable-gpu";

      ################
      ### ENV VARS ###
      ################
      # env = [
      #     "XCURSOR_SIZE, 24"
      #     "HYPRCURSOR_SIZE, 24"
      # ];

      #################
      ### AUTOSTART ###
      #################
      exec-once = [
        "$terminal"
        "$bitwarden"
        "waybar"
      ];

      #####################
      ### LOOK AND FEEL ###
      #####################
      general = {
        gaps_in = 5;
        gaps_out = 3;
        border_size = 3;
        "col.active_border" = "$lavender $peach 30deg";
        "col.inactive_border" = "$crust";
      };
      decoration = {
        shadow = {
          enabled = false;
          offset = "0 5";
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
        rounding = 10;
        rounding_power = 2;
        active_opacity = 1.0;
        inactive_opacity = 0.9;
      };
      animations = {
        enabled = true;
      };
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      master = {
        new_status = "master";
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      #############
      ### INPUT ###
      #############
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0; # -1.0 ~ 1.0, 0는 기본값
        touchpad = {
          natural_scroll = false;
        };
      };

      ##################
      ### WINDOWRULE ###
      ##################
      windowrule = [
        "pseudo on, match:class fcitx"
        "suppress_event maximize, match:class .*"
        "no_focus on, match:class ^$, match:title ^$, match:xwayland 1, match:float 1, match:fullscreen 0, match:pin 0"
        # "pseudo, class:fcitx"
        # "suppressevent maximize, class:.*"
        # "nofocus, class:^$, title:^$, xwayland:1, floating:1, fullscreen:0, pinned:0"
      ];
      windowrulev2 = [
        "no_focus on, class:^$, title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        # "nofocus, class:^$, title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
        "suppressevent maximize, class:.*"
        "workspace name:Emacs, class:^(emacs).*$"
        "workspace name:Term, class:^(kitty)$"
        "workspace name:Term, class:^.*(wezterm)$"
        "workspace name:Term, initialTitle:^([Gg]hostty)"
        "workspace name:Notion, class:^([Nn]otion)"
        "workspace name:WWW, class:^([Vv]ivaldi).*$"
        "workspace name:Vimb, class:^(vimb).*$"
        "workspace special:Bitwarden, class:^([Bb]itwarden)"
        "workspace special:Discord, class:^([Dd]iscord)"
        "workspace special:Music, class:^([Gg]oogle-chrome)"
        "workspace special:Sns, class:^.*(telegram).*$"
      ];

      ################
      ### KEYBINDS ###
      ################
      bind = [
        # terminal
        "$mainMod, T, exec, pgrep $terminal && hyprctl dispatch workspace name:Term || $terminal"
        "$ctrlMod, T, exec, $terminal"
        "$shiftMod, T, movetoworkspace, name:Term"

        # notion
        "$mainMod, N, workspace, name:Notion" # no detecting for electron apps
        "$ctrlMod, N, exec, notion-app --enable-wayland-ime --ozone-platform=wayland"
        "$shiftMod, N, movetoworkspace, name:Notion"

        # music
        "$mainMod, M, togglespecialworkspace, Music"
        "$ctrlMod, M, exec, $chrome https://music.youtube.com"
        "$shiftMod, M, movetoworkspace, special:Music"

        # master layout
        "$mainMod, R, layoutmsg, swapwithmaster master"
        "$shiftMod, R, layoutmsg, focusmaster"

        # vavaldi browser
        "$mainMod, B, exec, pgrep vivaldi && hyprctl dispatch workspace name:WWW || $webBrowser"
        "$ctrlMod, B, exec, $webBrowser"
        "$shiftMod, B, movetoworkspace, name:WWW"

        # discord
        "$mainMod, D, togglespecialworkspace, Discord"
        "$ctrlMod, D, exec, discord --enable-wayland-ime --ozone-platform=wayland"
        "$shiftMod, D, movetoworkspace, special:Discord"

        # bitwarden
        "$mainMod, W, togglespecialworkspace, Bitwarden"
        "$ctrlMod, W, exec, $bitwarden"
        "$shiftMod, W, movetoworkspace, special:Bitwarden"

        # screenshot
        ", PRINT, exec, hyprshot -m output"
        "$mainMod, PRINT, exec, hyprshot -m window"
        "$shiftMod, PRINT, exec, hyprshot -m region"

        # the default example binds
        "$mainMod, C, killactive"
        "$mainMod, P, pseudo"
        "$mainMod, J, togglesplit"
        "$mainMod, SPACE, exec, $menu"

        # Moving around windows
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, down, movefocus, d"
        "$mainMod, up, movefocus, u"
        # also with vim bindings
        "$mainMod, h, movefocus, l"
        "$mainMod, j, movefocus, d"
        "$mainMod, k, movefocus, u"
        "$mainMod, l, movefocus, r"

        # audio control, refer to submaps below
        "$ctrlMod SHIFT, A, submap, audio"
      ]
      ++ (
        # switch to workspaces with main mod + 0-9
        # keycode can be obtained with wev(wayland event viewer)
        # https://wiki.hypr.land/Configuring/Binds/#uncommon-syms--binding-with-a-keycode
        builtins.concatLists (
          builtins.genList (
            i:
            let
              workspace = i + 1;
            in
            [
              "$mainMod, code:1${toString i}, workspace, ${toString workspace}"
              "$shiftMod, code:1${toString i}, movetoworkspace, ${toString workspace}"
            ]
          ) 9
        )
      );

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
    };
    submaps = {
      audio = {
        settings = {
          bind = [
            ", l, exec, pactl set-sink-port 0 analog-output-lineout"
            ", h, exec, pactl set-sink-port 0 analog-output-headphones"
            ", escape, submap, reset"
          ];
        };
      };
    };
  };
  programs.wofi.enable = true;
}
