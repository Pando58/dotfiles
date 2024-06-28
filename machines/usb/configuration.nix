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
    ./usb-configuration.nix
    ./hardware-configuration.nix
  ];

  # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/installer/cd-dvd/installation-cd-base.nix#L49
  system.stateVersion = lib.mkDefault lib.trivial.release;
  nixpkgs.hostPlatform = lib.mkDefault system;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # boot.kernelPackages = pkgs.linuxPackages_latest;

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

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Networking
  networking.hostName = hostname;
  networking.networkmanager.enable = true;

  networking.useDHCP = lib.mkDefault true;
}
