{
  config,
  pkgs,
  lib,
  stateVersion,
  hostname,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];


  system.stateVersion = stateVersion;

  time.timeZone = "America/Mexico_City";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_MX.UTF-8";
    LC_IDENTIFICATION = "es_MX.UTF-8";
    LC_MEASUREMENT = "es_MX.UTF-8";
    LC_MONETARY = "es_MX.UTF-8";
    LC_NAME = "es_MX.UTF-8";
    LC_NUMERIC = "es_MX.UTF-8";
    LC_PAPER = "es_MX.UTF-8";
    LC_TELEPHONE = "es_MX.UTF-8";
    LC_TIME = "es_MX.UTF-8";
  };

  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.useOSProber = true;

  # Networking
  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  # Polkit
  security.polkit.enable = true;

  # Graphics
  services.xserver = {
    videoDrivers = ["nvidia"];
    exportConfiguration = true;
    dpi = 96;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };


  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;

    # experimental, can cause sleep/suspend to fail
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    # use the nvidia open source kernel module (not to be confused with the independent third-party "nouveau" open source driver).
    # https://github.com/NVIDIA/open-gpu-kernel-modules
    # do not disable this unless your GPU is unsupported or if you have a good reason to.
    open = true;

    # Enable the nvidia-settings menu,
    nvidiaSettings = true;
  };
}
