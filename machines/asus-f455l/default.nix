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
    (import ../../local/machines/asus-f455l (inputs // { inherit username; }))
    ../../nixconfig/neovim
  ];

  # Programs
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = (with pkgs; [
    stow
    virt-manager
    wineWowPackages.stable
    winetricks
    sshfs

    arc-theme
    papirus-icon-theme
    vanilla-dmz
    xclip
    feh
    xdragon
    redshift
    playerctl
    alsa-utils
    pulsemixer
    pavucontrol
    pcmanfm
    networkmanagerapplet
    bluetui
    flameshot
    gimp-with-plugins
  ]) ++ (with pkgs-unstable; [
    picom
    wezterm
    fish
    tmux
    fzf
    yazi
    rofi
    rofimoji
    lazygit
    brave
    dtrx
    ventoy
  ]);

  programs.dconf.enable = true; # Needed for GTK and virtualization
  services.gvfs.enable = true; # Mounting and trash support for file managers
  security.polkit.enable = true;

  # Git
  programs.git = {
    enable = true;
    config = {
      init.defaultBranch = "main";
    };
  };

  virtualisation.libvirtd.enable = true;

  # PlatformIO
  services.udev.packages = with pkgs; [
    platformio-core.udev
    openocd
  ];

  # Graphics
  services.xserver = {
    enable = true;
    dpi = 96;

    displayManager = {
      startx.enable = true;
    };

    windowManager.awesome.enable = true;
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
  };
}
