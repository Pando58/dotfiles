inputs @ {
  config,
  pkgs,
  pkgs-unstable,
  stateVersion,
  hostname,
  neovim-config,
  latex-config,
  ...
}: let
  username = "pando";
in {
  imports = [
    ./configuration.nix
    (import ../../local/machines/main (inputs // { inherit username; }))
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

  # PlatformIO
  services.udev.packages = with pkgs; [
    platformio-core
    openocd
  ];

  # X Server
  services.xserver = {
    enable = true;

    displayManager = {
      lightdm.enable = true;

      autoLogin = {
        enable = true;
        user = username;
      };

      sessionCommands = ''
        setxkbmap -option compose:ralt -option caps:escape_shifted_capslock &
        ~/.fehbg &
        redshift -P -O 4500 -g 1.1 -b 1 &
        picom &
        dex -a -s ~/.config/autostart &
      '';
    };

    windowManager = {
      awesome.enable = true;
    };
  };

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
      "dialout"
    ];
    packages = [];
    shell = pkgs-unstable.fish;
  };

  # services.getty.autologinUser = username;

  # Home Manager
  home-manager.users.${username} = {
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

    # Packages
    home.packages = (with pkgs; [
      xclip
      dex
      feh
      xdragon
      redshift
      playerctl
      alsa-utils
      pulsemixer
      pavucontrol
      pcmanfm
      networkmanagerapplet
    ]) ++ (with pkgs-unstable; [
      picom
      wezterm
      rofi
      rofimoji
      lazygit
      brave
      dtrx
      ventoy
    ]);

    # Dotfiles
    xdg.configFile = {
      awesome = { recursive = true; source = ../../config/home/.config/awesome; };
      picom = { recursive = true; source = ../../config/home/.config/picom; };
      alacritty = { recursive = true; source = ../../config/home/.config/alacritty; };
      wezterm = { recursive = true; source = ../../config/home/.config/wezterm; };
      fish = { recursive = true; source = ../../config/home/.config/fish; };
      rofi = { recursive = true; source = ../../config/home/.config/rofi; };
      rofimoji = { recursive = true; source = ../../config/home/.config/rofimoji; };
      "rofimoji.rc" = { source = ../../config/home/.config/rofimoji.rc; };
      "autostart/nm-applet.desktop" = { source = ../../config/home/.config/autostart/nm-applet.desktop; };
    };

    # Program config
    imports = [
      neovim-config.config
      (import ../../nixconfig/tmux (inputs // { pkgs = pkgs-unstable; }))
      latex-config.config
    ];

    # Fish
    programs.fish = {
      enable = true;
      package = pkgs-unstable.fish;
    };

    # Flameshot
    services.flameshot = {
      enable = true;
      settings.General = {
        disabledTrayIcon = true;
        showStartupLaunchMessage = false;
        filenamePattern = "%F_%H-%M-%S";
        showMagnifier = true;
        squareMagnifier = true;
        contrastOpacity = 75;
      };
    };

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
    };

    home.pointerCursor = {
      name = "Vanilla-DMZ";
      package = pkgs.vanilla-dmz;
      size = 0;
      x11.enable = true;
      gtk.enable = true;
    };
  };
}
