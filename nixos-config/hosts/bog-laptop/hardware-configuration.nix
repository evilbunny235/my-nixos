{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" "sdhci_pci"];
  boot.initrd.kernelModules = ["yt6801"];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [config.boot.kernelPackages.yt6801];
  boot.kernelParams = [
    "intel_iommu=on"
  ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/c3a7d4b5-e368-46d0-a2b3-3050bcc328ec";
    fsType = "ext4";
    options = ["noatime"];
  };

  boot.initrd.luks.devices."luks-649cf6c0-c638-44e9-93a7-2403071af1bd".device = "/dev/disk/by-uuid/649cf6c0-c638-44e9-93a7-2403071af1bd";
  boot.initrd.luks.devices."luks-d0fc23c8-a568-43cf-81af-22c2e84ebde4".device = "/dev/disk/by-uuid/d0fc23c8-a568-43cf-81af-22c2e84ebde4";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/6B83-A3B9";
    fsType = "vfat";
    options = ["fmask=0077" "dmask=0077"];
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/37b4ba4d-baaf-4f53-a145-c781a4432046";}
  ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
