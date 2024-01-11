{
  pkgs,
  lib,
  ...
}: let
  extensions = with pkgs.gnomeExtensions; [
    # forge
    pop-shell
    just-perfection
    unite-shell
    blur-my-shell
    compiz-windows-effect
    gnome-40-ui-improvements
    caffeine
  ];
in {
  home.packages = extensions;

  dconf.settings = {
    # Extensions
    "org/gnome/shell" = {
      enabled-extensions = (
        map (ext: ext.extensionUuid) extensions
      ) ++ [
        "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
        "drive-menu@gnome-shell-extensions.gcampax.github.com"
      ];
      disabled-extensions = [];
      favorite-apps = [
        "org.gnome.Settings.desktop"
        "org.gnome.Nautilus.desktop"
        "brave-browser.desktop"
        "org.wezfurlong.wezterm.desktop"
      ];
    };

    # "org/gnome/shell/extensions/forge" = {
    #   stacked-tiling-mode-enabled = false;
    #   tabbed-tiling-mode-enabled = false;
    #   focus-border-size = 2;
    #   focus-border-color = "#b8d1e6";
    # };

    # "org/gnome/shell/extensions/forge/keybindings" = {
    #   window-focus-up = ["<Super>w"];
    #   window-focus-left = ["<Super>a"];
    #   window-focus-down = ["<Super>s"];
    #   window-focus-right = ["<Super>d"];
    #
    #   window-move-up = ["<Shift><Super>w"];
    #   window-move-left = ["<Shift><Super>a"];
    #   window-move-down = ["<Shift><Super>s"];
    #   window-move-right = ["<Shift><Super>d"];
    #
    #   window-resize-top-increase = ["<Super>i"];
    #   window-resize-left-increase = ["<Super>j"];
    #   window-resize-bottom-increase = ["<Super>k"];
    #   window-resize-right-increase = ["<Super>l"];
    #   window-resize-top-decrease = ["<Shift><Super>i"];
    #   window-resize-left-decrease = ["<Shift><Super>j"];
    #   window-resize-bottom-decrease = ["<Shift><Super>k"];
    #   window-resize-right-decrease = ["<Shift><Super>l"];
    #
    #   window-toggle-float = ["<Control><Super>space"];
    #
    #   window-gap-size-decrease = [];
    #   window-gap-size-increase = [];
    #   window-snap-one-third-left = [];
    #   window-snap-one-third-right = [];
    #   window-snap-two-third-left = [];
    #   window-snap-two-third-right = [];
    #   window-swap-up = [];
    #   window-swap-left = [];
    #   window-swap-down = [];
    #   window-swap-right = [];
    #   window-toggle-always-float = [];
    #   workspace-active-tile-toggle = [];
    #   con-split-horizontal = [];
    #   con-split-vertical = [];
    #   con-split-layout-toggle = [];
    #   con-stacked-layout-toggle = [];
    #   con-tabbed-layout-toggle = [];
    #   con-tabbed-showtab-decoration-toggle = [];
    #   focus-border-toggle = [];
    #   prefs-open = [];
    #   prefs-tiling-toggle = [];
    # };

    "org/gnome/shell/extensions/just-perfection" = {
      power-icon = false;
      workspace-wrap-around = true;
      window-demands-attention-focus = true;
      overlay-key = false;
      double-super-to-appgrid = false;
      animation = 4;
      notification-banner-position = 2;
    };

    "org/gnome/shell/extensions/blur-my-shell" = {
      sigma = 20;
      color = lib.hm.gvariant.mkTuple [0.1 0.1 0.1 0.4];
      brightness = 0.4;
    };

    "org/gnome/shell/extensions/blur-my-shell/applications" = {
      customize = true;
      sigma = 15;
      opacity = 255;
      whitelist = [
        "org.wezfurlong.wezterm"
      ];
    };

    "org/gnome/shell/extensions/compiz-window-effect" = {
      friction = 4.0;
      spring-k = 2.0;
      speedup-factor-divider = 2.6;
      mass = 50.0;
    };

    # Key bindings
    "org/gnome/desktop/wm/keybindings" = {
      move-to-monitor-up = ["<Shift><Control><Super>w"];
      move-to-monitor-left = ["<Shift><Control><Super>a"];
      move-to-monitor-down = ["<Shift><Control><Super>s"];
      move-to-monitor-right = ["<Shift><Control><Super>d"];

      move-to-workspace-left = ["<Shift><Super>q"];
      move-to-workspace-right = ["<Shift><Super>e"];

      switch-to-workspace-left = ["<Super>q"];
      switch-to-workspace-right = ["<Super>e"];

      close = ["<Shift><Super>x"];

      toggle-fullscreen = ["<Shift><Super>f"];

      show-screenshot-ui = ["<Alt><Super>s"];
      toggle-message-tray = ["<Super>n"];
      focus-active-notification = ["<Alt><Super>n"];

      move-to-workspace-last = [];
      switch-to-workspace-last = [];
      move-to-workspace-1 = [];
      switch-to-workspace-1 = [];
      switch-applications = [];
      switch-applications-backward = [];
      switch-panels = [];
      switch-panels-backward = [];
      cycle-panels-backward = [];
      show-screen-recording-ui = [];
      restore-shortcuts = [];
      begin-move = [];
      begin-resize = [];
    };

    "org/gnome/shell/keybindings" = {
      toggle-overview = ["<Super>space"];
      toggle-application-view = ["<Alt><Super>space"];
      toggle-quick-settings = ["<Control><Super>Tab"];

      switch-to-application-1 = [];
      switch-to-application-2 = [];
      switch-to-application-3 = [];
      switch-to-application-4 = [];
      switch-to-application-5 = [];
      switch-to-application-6 = [];
      switch-to-application-7 = [];
      switch-to-application-8 = [];
      switch-to-application-9 = [];
      switch-to-application-0 = [];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      home = ["<Alt><Super>e"];
      mic-mute = ["<Super>m"];

      volume-step = 5;

      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];

      screenreader = [];
      screensaver = [];
      logout = [];
    };

    # Custom key bindings
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>t";
      command = "wezterm";
      name = "Launch terminal (WezTerm)";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>b";
      command = "brave";
      name = "Launch web browser (Brave)";
    };

    #
    "org/gnome/desktop/wm/preferences" = {
      resize-with-right-button = true;
      focus-mode = "sloppy";
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      center-new-windows = true;
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Arc-Dark";

      enable-hot-corners = false;

      clock-show-weekday = true;
      clock-show-date = true;
      clock-show-seconds = true;
      clock-show-weekdate = true;

      font-name = "Inter 10";
      document-font-name = "Inter 10";
      monospace-font-name = "JetBrainsMonoNL Nerd Font 10";
    };

    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
      power-button-action = "interactive"; # Power off
    };

    "org/gnome/desktop/input-sources" = {
      xkb-options = [
        "compose:ralt"
        "caps:escape_shifted_capslock"
      ];

    };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-schedule-automatic = false;
      night-light-schedule-from = 0.0;
      night-light-schedule-to = 0.0;
      night-light-temperature = lib.hm.gvariant.mkUint32 3700;
    };

    "org/gtk/gtk4/settings/file-chooser" = {
      show-hidden = true;
    };
  };
}
