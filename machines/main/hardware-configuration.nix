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

  boot.loader.grub.device = "/dev/nvme0n1";

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/e99bb45e-39de-42ec-8b2e-bf22eb3519b2";
      fsType = "ext4";
    };
  };

  swapDevices = [{ device = "/dev/disk/by-uuid/709f8602-f6c5-414a-9718-4d8816153ab6"; }];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
