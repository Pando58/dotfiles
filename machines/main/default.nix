args @ {
  config,
  pkgs,
  stateVersion,
  hostname,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    (import ./user.nix (args // { inherit stateVersion; }))
  ];
  
  # Boot
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;

  # NTFS support
  boot.supportedFilesystems = [ "ntfs" ];

  # Host
  networking.hostName = hostname;
  time.timeZone = "America/Mexico_City";
  i18n.defaultLocale = "en_US.UTF-8";
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "";

  # Networking
  networking.networkmanager.enable = true;

  # Audio
  security.rtkit.enable = true; # optional but recommended

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    lxsession
  ];

  # NVIDIA
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.nvidia.modesetting.enable = true;
  #services.gnome.at-spi2-core.enable = true;

  # System version
  system.stateVersion = stateVersion;
}
