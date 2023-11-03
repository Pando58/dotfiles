inputs @ {
  pkgs,
  stateVersion,
  ...
}: let
  username = "pando";
  password = "135642";
in {
  imports = [
    ./configuration.nix
    (import ./local.nix (inputs // { inherit username; }))
  ];

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
    enableDefaultFonts = true;

    fonts = with pkgs; [
      inter
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];

    fontconfig.defaultFonts = {
      sansSerif = [ "Inter" ];
      monospace = [ "JetBrainsMono" ];
    };
  };

  # Users
  users.users.root.password = password;

  users.users.${username} = {
    isNormalUser = true;
    description = username;
    password = password;
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

    # Programs and config files
    home.packages = with pkgs; [
      picom
      alacritty
      fish
      xclip
      rofi
      rofimoji
      dex
      feh
      dtrx
      xdragon
      redshift
      playerctl
      pulsemixer
      pavucontrol
      pcmanfm
      networkmanagerapplet
      neovim
    ];

    xdg.configFile = {
      awesome = { recursive = true; source = ../../config/home/.config/awesome; };
      picom = { recursive = true; source = ../../config/home/.config/picom; };
      alacritty = { recursive = true; source = ../../config/home/.config/alacritty; };
      fish = { recursive = true; source = ../../config/home/.config/fish; };
      rofi = { recursive = true; source = ../../config/home/.config/rofi; };
      rofimoji = { recursive = true; source = ../../config/home/.config/rofimoji; };
      "rofimoji.rc" = { source = ../../config/home/.config/rofimoji.rc; };
      "autostart/nm-applet.desktop" = { source = ../../config/home/.config/autostart/nm-applet.desktop; };
      # nvim = { recursive = true; source = ../../config/home/.config/nvim; };
    };

    # Neovim
    # programs.neovim = {
    #   enable = true;
    #   plugins = with pkgs.vimPlugins; [];
    # };

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
