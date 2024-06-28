{
  config,
  lib,
  options,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    "${modulesPath}/installer/cd-dvd/iso-image.nix"
    "${modulesPath}/profiles/all-hardware.nix"
    "${modulesPath}/profiles/base.nix"
    "${modulesPath}/installer/cd-dvd/channel.nix" # doesn't work
  ];


  # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/installer/cd-dvd/installation-cd-base.nix#L18

  # Adds terminus_font for people with HiDPI displays
  console.packages = options.console.packages.default ++ [ pkgs.terminus_font ];

  # ISO naming.
  isoImage.isoName = "${config.isoImage.isoBaseName}-${config.system.nixos.label}-${pkgs.stdenv.hostPlatform.system}.iso";

  # EFI booting
  isoImage.makeEfiBootable = true;

  # USB booting
  isoImage.makeUsbBootable = true;

  # Add Memtest86+ to the CD.
  boot.loader.grub.memtest86.enable = true;


  # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/profiles/base.nix#L51

  # Include support for various filesystems and tools to create / manipulate them.
  boot.supportedFilesystems =
    [ "btrfs" "cifs" "f2fs" "jfs" "ntfs" "reiserfs" "vfat" "xfs" ] ++
    lib.optional (lib.meta.availableOn pkgs.stdenv.hostPlatform config.boot.zfs.package) "zfs";

  # Configure host id for ZFS to work
  networking.hostId = lib.mkDefault "8425e349";


  # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/profiles/installation-device.nix#L86

  # Tell the Nix evaluator to garbage collect more aggressively.
  # This is desirable in memory-constrained environments that don't
  # (yet) have swap set up.
  environment.variables.GC_INITIAL_HEAP_SIZE = "1M";

  # Make the installer more likely to succeed in low memory
  # environments.  The kernel's overcommit heustistics bite us
  # fairly often, preventing processes such as nix-worker or
  # download-using-manifests.pl from forking even if there is
  # plenty of free memory.
  boot.kernel.sysctl."vm.overcommit_memory" = "1";

  # To speed up installation a little bit, include the complete
  # stdenv in the Nix store on the CD.
  system.extraDependencies = with pkgs;
  [
  stdenv
  stdenvNoCC # for runCommand
  busybox
  jq # for closureInfo
  # For boot.initrd.systemd
  makeInitrdNGTool
  ];

  boot.swraid.enable = true;
  # remove warning about unset mail
  boot.swraid.mdadmConf = "PROGRAM ${pkgs.coreutils}/bin/true";
}
