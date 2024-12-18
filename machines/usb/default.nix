inputs @ {
  pkgs,
  pkgs-unstable,
  stateVersion,
  neovim-config,
  latex-config,
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

  environment.systemPackages = (with pkgs; [
    stow
    sshfs

    arc-theme
    papirus-icon-theme
    vanilla-dmz
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
    flameshot
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
  };
}
