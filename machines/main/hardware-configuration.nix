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

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/db67061b-d46c-454c-9617-69dca1155076";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/0200-E176";
      fsType = "vfat";
    };
  };

  swapDevices = [{ device = "/dev/disk/by-uuid/29844642-589a-4ed9-a611-7b9c910c88f9"; }];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Graphics
  services.xserver = {
    videoDrivers = ["nvidia"];
    exportConfiguration = true;
  };

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    open = false;

    nvidiaSettings = true;

    modesetting.enable = true;

    powerManagement.enable = false;
    powerManagement.finegrained = false;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
}
