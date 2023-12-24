{
  config,
  pkgs,
  lib,
  system,
  stateVersion,
  hostname,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  system.stateVersion = stateVersion;
  nixpkgs.hostPlatform = lib.mkDefault system;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

  # Networking
  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  networking.useDHCP = lib.mkDefault true;
}
