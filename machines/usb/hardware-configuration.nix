{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  # hardware.enableAllFirmware = true;
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems = {
    "/nix/.rw-store" = lib.mkForce {
      device = "/dev/disk/by-label/K128_nixstore";
      fsType = "ext4";
      neededForBoot = true;
    };
    "/mnt/K128_files" = {
      device = "/dev/disk/by-label/K128_files";
      fsType = "ext4";
      neededForBoot = false;
    };
    "/mnt/K128_exfat" = {
      device = "/dev/disk/by-label/K128_exfat";
      fsType = "exfat";
      neededForBoot = false;
    };
  };

  swapDevices = [{ device = "/dev/disk/by-label/K128_swap"; }];

  # Graphics
  services.xserver = {
    exportConfiguration = true;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}
