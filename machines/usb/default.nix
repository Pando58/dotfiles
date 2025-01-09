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
    ../../nixconfig/neovim
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
    feh
    xdragon
    redshift
    playerctl
    alsa-utils
    pulsemixer
    pavucontrol
    xfce.thunar
    xfce.thunar-volman
    xfce.thunar-archive-plugin
    xfce.thunar-media-tags-plugin
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

  # Services
  systemd.user.services = {
    stow-dotfiles = {
      path = with pkgs; [ stow ];
      script = "stow -d /mnt/K128_files/dotfiles/config/nixos -t $HOME home";
      wantedBy = ["default.target"];
    };
    stow-ssh = {
      path = with pkgs; [ stow ];
      script = "mkdir -p $HOME/.ssh; stow -d /mnt/K128_files/ssh -t $HOME/.ssh .";
      wantedBy = ["default.target"];
    };
    stow-autostart = {
      path = with pkgs; [ stow ];
      script = "mkdir -p $HOME/.config/autostart; stow -d /mnt/K128_files/config -t $HOME/.config/autostart autostart";
      wantedBy = ["default.target"];
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
