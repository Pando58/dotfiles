args @ {
  # config,
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

  # Host
  networking.hostName = hostname;
  time.timeZone = "America/Mexico_City";
  i18n.defaultLocale = "en_US.UTF-8";
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "";

  # Networking
  networking.networkmanager.enable = true;

  # Packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [];

  # System version
  system.stateVersion = stateVersion;
}
