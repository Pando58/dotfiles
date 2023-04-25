{
  pkgs,
  stateVersion,
  ...
}: let
  username = "pando";
in {
  # Create user
  users.users.${username} = {
    isNormalUser = true;
    description = "Pando";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [];
  };

  # Programs
  services.xserver.enable = true;
  programs.dconf.enable = true; # Needed for GTK and virtualization
  services.gvfs.enable = true; # Mounting and trash support for file managers
  programs.steam.enable = true;
  virtualisation.libvirtd.enable = true;

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
  
  # Sessions
  services.xserver.displayManager.session = [
    {
      name = "awesome";
      manage = "window";
      start = ''
        lxsession &
        xrandr --output DP-4 --mode 2560x1440 --pos 1920x480 --primary --output HDMI-0 --mode 1920x1080 --pos 4480x60 --rotate left --output DP-1 --mode 1920x1080 --pos 0x580
        redshift -P -O 4500 -g 1.1 -b 0.9
        picom &
        awesome
      '';
    }
  ];

  # environment.variables.XCURSOR_SIZE = "32"; # home.pointerCursor.size does not work

  # Home Manager
  home-manager.users.${username} = {
    home = {
      inherit username stateVersion;
      homeDirectory = "/home/${username}";
    };

    nixpkgs.config.allowUnfree = true;

    imports = map (f: ../../programs + "/${f}") [
      "git"
      "awesome"
      "picom"
      "fish"
      "neofetch"
      "alacritty"
      "rofi"
      "flameshot"
      "pulsemixer"
      "playerctl"
      "feh"
      "redshift"
      "unzip"
      "brave"
      "vscodium"
      "geany"
      "neovim"
      "gnumake"
      "pcmanfm"
      "pavucontrol"
      "nodejs"
      "rust"
      "heroic"
      "discord"
      "reaper"
      "qpwgraph"
      "carla"
      "wine"
      "yabridge"
      "virt-manager"
    ];

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
    };
  };
}
