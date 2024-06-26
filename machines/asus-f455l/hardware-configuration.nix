{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/28d5f4d7-454e-4e75-a49b-ec190ee63bf5";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/9E49-E0C1";
      fsType = "vfat";
    };
  };

  swapDevices = [{ device = "/dev/disk/by-uuid/188f0dcd-63f9-462e-9948-55a6ab64e0ed"; }];

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Graphics
  services.xserver = {
    exportConfiguration = true;
  };
}
