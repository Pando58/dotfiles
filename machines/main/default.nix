inputs @ {
  config,
  pkgs,
  pkgs-unstable,
  stateVersion,
  hostname,
  ...
}: let
  username = "pando";
in {
  imports = [
    ./configuration.nix
    (import ../../local/machines/main (inputs // { inherit username; }))
    (import ../../nixconfig/gnome (inputs // { inherit username; }))
  ];

  # Programs
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    virt-manager
    wineWowPackages.stable
    winetricks
  ];

  programs.dconf.enable = true; # Needed for GTK and virtualization
  services.gvfs.enable = true; # Mounting and trash support for file managers
  security.polkit.enable = true;

  programs.git = {
    enable = true;
    config = {
      init.defaultBranch = "main";
    };
  };

  virtualisation.libvirtd.enable = true;

  # Audio
  security.rtkit.enable = true;

  musnix = {
    enable = true;
    # kernel.realtime = true;
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Fonts
  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      inter
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];

    fontconfig.defaultFonts = {
      sansSerif = [ "Inter" ];
      monospace = [ "JetBrainsMono" ];
    };
  };

  # Users
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirtd"
      "audio"
    ];
    packages = [];
  };

  # services.getty.autologinUser = username;

  # Home Manager
  home-manager.users.${username} = {
    imports = [
      (import ../../nixconfig/neovim (inputs // { pkgs = pkgs-unstable; }))
      ../../nixconfig/gnome/home.nix
    ];

    programs.home-manager.enable = true;

    home = {
      inherit username stateVersion;
      homeDirectory = "/home/${username}";
    };

    # Virt Manager config
    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
      };
    };

    # Programs
    home.packages = (with pkgs; [
      xclip
      # dex
      # feh
      xdragon
      # redshift
      playerctl
      pulsemixer
      pavucontrol
    ]) ++ (with pkgs-unstable; [
      wezterm
      brave
      dtrx
      ventoy
    ]);

    # Dotfiles
    xdg.configFile = {
      wezterm = { recursive = true; source = ../../config/home/.config/wezterm; };
      fish = { recursive = true; source = ../../config/home/.config/fish; };
      # awesome = { recursive = true; source = ../../config/home/.config/awesome; };
      # picom = { recursive = true; source = ../../config/home/.config/picom; };
      # alacritty = { recursive = true; source = ../../config/home/.config/alacritty; };
      # rofi = { recursive = true; source = ../../config/home/.config/rofi; };
      # rofimoji = { recursive = true; source = ../../config/home/.config/rofimoji; };
      # "rofimoji.rc" = { source = ../../config/home/.config/rofimoji.rc; };
      # "autostart/nm-applet.desktop" = { source = ../../config/home/.config/autostart/nm-applet.desktop; };
    };

    # Fish
    programs.fish = {
      enable = true;
      package = pkgs-unstable.fish;
    };

    # Flameshot
    # services.flameshot = {
    #   enable = true;
    #   settings.General = {
    #     disabledTrayIcon = true;
    #     showStartupLaunchMessage = false;
    #     filenamePattern = "%F_%H-%M-%S";
    #     showMagnifier = true;
    #     squareMagnifier = true;
    #     contrastOpacity = 75;
    #   };
    # };

    # Theme
    gtk = {
      enable = true;

      theme = {
        name = "Arc-Dark";
        package = pkgs.arc-theme;
      };

      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };

      cursorTheme = {
        name = "Vanilla-DMZ";
        package = pkgs.vanilla-dmz;
      };
    };

    home.sessionVariables.GTK_THEME = "Arc-Dark";

    home.pointerCursor = {
      name = "Vanilla-DMZ";
      package = pkgs.vanilla-dmz;
      size = 0;
      x11.enable = true;
      gtk.enable = true;
    };
  };
}
