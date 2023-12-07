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

  swapDevices = [{ device = "/dev/disk/by-label/K128_swap"; }];

  # Graphics
  services.xserver = {
    exportConfiguration = true;
    dpi = 96;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
}
