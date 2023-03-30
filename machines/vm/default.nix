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
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

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
