inputs @ {
  pkgs,
  pkgs-unstable,
  stateVersion,
  ...
}: let
  username = "pando";
in {
  imports = [
    ./configuration.nix
    (import ../../local/machines/usb (inputs // { inherit username; }))
  ];

  # Faster building
  isoImage.squashfsCompression = "gzip -Xcompression-level 1";

  # Programs
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = [];

  programs.dconf.enable = true; # Needed for GTK and virtualization
  services.gvfs.enable = true; # Mounting and trash support for file managers
  security.polkit.enable = true;

  programs.git = {
    enable = true;
    config = {
      init.defaultBranch = "main";
    };
  };

  # X Server
  services.xserver = {
    enable = true;

    displayManager = {
      lightdm.enable = true;

      # autoLogin = {
      #   enable = true;
      #   user = username;
      # };

      sessionCommands = ''
        setxkbmap -option compose:ralt -option caps:escape_shifted_capslock &
        redshift -P -O 4500 -g 1.1 -b 1 &
        dex -a -s ~/.config/autostart &
      '';
    };

    windowManager = {
      awesome.enable = true;
    };
  };

  # Audio
  security.rtkit.enable = true;

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
    ];
    packages = [];
  };

  # Home Manager
  home-manager.users.${username} = {
    programs.home-manager.enable = true;

    home = {
      inherit username stateVersion;
      homeDirectory = "/home/${username}";
    };

    # Programs
    home.packages = (with pkgs; [
      xclip
      dex
      feh
      xdragon
      redshift
      playerctl
      pulsemixer
      pavucontrol
      pcmanfm
      networkmanagerapplet
    ]) ++ (with pkgs-unstable; [
      picom
      wezterm
      rofi
      rofimoji
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

    # Fish
    programs.fish = {
      enable = true;
      package = pkgs-unstable.fish;
    };

    # Neovim
    imports = [
      (import ../../nixconfig/neovim (inputs // { pkgs = pkgs-unstable; }))
    ];

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
