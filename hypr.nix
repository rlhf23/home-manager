{
  config,
  pkgs,
  ...
}: {
  home.file = {
    # mkOutOfStoreSymlink needs absolute path
    ".config/waybar/config.jsonc".source = config.lib.file.mkOutOfStoreSymlink /home/nix/.config/home-manager/waybar/config.jsonc;
    ".config/waybar/style.css".source = config.lib.file.mkOutOfStoreSymlink /home/nix/.config/home-manager/waybar/style.css;
    # ".config/waybar/config.jsonc".source = ./waybar/config.jsonc;
    # ".config/waybar/style.css".source = ./waybar/style.css;
  };
  home.packages = with pkgs; [
    wl-clipboard
    brightnessctl
    pavucontrol
    waybar
    networkmanagerapplet
    rofi-wayland
    lxqt.lxqt-policykit
    pcmanfm
    feh
    dunst
    upower
    hypridle
  ];
  services = {
    wpaperd = {
      enable = true;
      settings = {
        default = {
          duration = "90m";
          mode = "center";
          sorting = "random";
          path = "/home/share/Wallpapers";
        };
      };
    };
    hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = ""; # No lock command
          before_sleep_cmd = "dunstify \"Zzz\""; # command ran before sleep
          after_sleep_cmd = "dunstify \"Awake!\""; # command ran after sleep
        };
        listener = [
          {
            timeout = 600; # 10 minutes
            on-timeout = "hyprctl dispatch dpms off"; # Turn off screen
            on-resume = "hyprctl dispatch dpms on"; # Turn on screen
          }
          {
            timeout = 900; # 15 minutes
            on-timeout = "systemctl suspend"; # Suspend
            on-resume = ""; # No special command on resume
          }
        ];
      };
    };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    package = null;
    portalPackage = null;
    settings = {
      env = [
        # "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];
      exec-once = [
        "wpaperd -d"
        "lxqt-policykit-agent"
        "waybar"
        "nm-applet --indicator & disown"
        "blueman-applet"
        "dunst"
        "hypridle"
      ];

      monitor = [
        ",preferred,auto,1"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;

        "col.active_border" = "rgba(ff00ffee) rgba(00ff00ee) 45deg";
        "col.inactive_border" = "rgba(4b0082aa)";

        layout = "dwindle";
        resize_on_border = true;
      };

      misc = {
        disable_splash_rendering = true;
        # force_default_wallpaper = 1;
      };

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          drag_lock = true;
        };
        sensitivity = 0;
        float_switch_override_focus = 2;
      };

      binds = {
        allow_workspace_cycles = true;
      };

      dwindle = {
        pseudotile = "yes";
        preserve_split = "yes";
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_touch = true;
        workspace_swipe_use_r = true;
      };

      windowrule = let
        f = regex: "float, ^(${regex})$";
      in [
        (f "org.gnome.Calculator")
        (f "org.gnome.Nautilus")
        (f "pavucontrol")
        (f "nm-connection-editor")
        (f "blueberry.py")
        (f "org.gnome.Settings")
        (f "org.gnome.design.Palette")
        (f "Color Picker")
        (f "xdg-desktop-portal")
        (f "xdg-desktop-portal-gnome")
        (f "de.haeckerfelix.Fragments")
        "workspace 7, title:Spotify"
      ];

      bind = let
        binding = mod: cmd: key: arg: "${mod}, ${key}, ${cmd}, ${arg}";
        mvfocus = binding "SUPER" "movefocus";
        ws = binding "SUPER" "workspace";
        resizeactive = binding "SUPER CTRL" "resizeactive";
        mvactive = binding "SUPER ALT" "moveactive";
        mvtows = binding "SUPER SHIFT" "movetoworkspace";
        arr = [1 2 3 4 5 6 7];
      in
        [
          "CTRL SHIFT, R, exec,         marble quit; marble"
          # "SUPER, R, exec,              marble toggle launcher"
          "SUPER, R, exec,              rofi -show run"
          "SUPER, Tab, exec,            marble eval \"launcher('h')\""
          # ",XF86PowerOff, exec,         marble toggle powermenu"
          ",XF86Launch4, exec,          screenrecord"
          "SHIFT, XF86Launch4, exec,    screenrecord --full"
          ",Print, exec,                screenshot"
          "SHIFT, Print, exec,          screenshot --full"
          "SUPER, Q, exec,              kitty"
          "SUPER, F, exec,              librewolf"
          "SUPER, E, exec,              pcmanfm"
          "CTRL ALT, W, exec,           pkill waybar || waybar"
          "SUPER, N, exec,              wpaperctl next"

          "ALT, Tab,            focuscurrentorlast"
          "SUPER, M,            exit"
          "SUPER, C,            killactive"
          "SUPER, V,            togglefloating"
          "SUPER, G,            fullscreen"
          "SUPER, W,            togglesplit"

          (mvfocus "k" "u")
          (mvfocus "j" "d")
          (mvfocus "l" "r")
          (mvfocus "h" "l")
          (ws "left" "e-1")
          (ws "right" "e+1")
          (mvtows "left" "e-1")
          (mvtows "right" "e+1")
          (resizeactive "k" "0 -20")
          (resizeactive "j" "0 20")
          (resizeactive "l" "20 0")
          (resizeactive "h" "-20 0")
          (mvactive "k" "0 -20")
          (mvactive "j" "0 20")
          (mvactive "l" "20 0")
          (mvactive "h" "-20 0")
        ]
        ++ (map (i: ws (toString i) (toString i)) arr)
        ++ (map (i: mvtows (toString i) (toString i)) arr);

      bindle = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];

      bindm = [
        "SUPER, mouse:273, resizewindow"
        "SUPER, mouse:272, movewindow"
      ];

      decoration = {
        rounding = 5;

        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(0,0,0,0.3)";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 3;
          new_optimizations = "on";
          noise = 0.01;
          contrast = 0.9;
          brightness = 0.8;
          popups = true;
        };
      };

      animations = {
        enabled = "yes";
        bezier = [
          "myBezier, 0.05, 0.5, 0.1, 1.0" # Even faster bezier curve
          "quickOut, 0.1, 0.8, 0.1, 1.0"
        ];
        animation = [
          "windows, 1, 2, myBezier" # Reduced to 2
          "windowsOut, 1, 2, quickOut, popin 80%" # Reduced to 2
          "border, 1, 2, default" # Reduced to 2
          "fade, 1, 2, quickOut" # Reduced to 2
          "workspaces, 1, 2, quickOut" # Reduced to 2
        ];
      };
    };
  };
}
