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
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Programs
  services.xserver.enable = true;
  programs.dconf.enable = true; # Needed for GTK
  programs.steam.enable = true;

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
        xrandr --output DP-0 --mode 2560x1440 --pos 1920x480 --primary --output HDMI-0 --mode 1920x1080 --pos 4480x60 --rotate left --output DP-5 --mode 1920x1080 --pos 0x580
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

    imports = map (f: ../../programs + "/${f}") [
      "git"
      "awesome"
      "fish"
      "neofetch"
      "alacritty"
      "rofi"
      "flameshot"
      "feh"
      "brave"
      "vscodium"
      "pcmanfm"
      "nodejs"
      "rust"
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
