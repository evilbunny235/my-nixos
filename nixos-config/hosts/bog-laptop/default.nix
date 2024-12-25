{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../common.nix
    ../../packages/scripts/screenshot.nix
  ];

  boot.initrd.luks.devices."luks-d0fc23c8-a568-43cf-81af-22c2e84ebde4".device = "/dev/disk/by-uuid/d0fc23c8-a568-43cf-81af-22c2e84ebde4";

  networking.hostName = "bog-laptop";

  hardware = {
    tuxedo-rs = {
      enable = true;
      tailor-gui.enable = true;
    };
  };

  environment = {
    systemPackages = [
      pkgs.heaptrack
      pkgs.ranger
    ];
  };

  users.users.bogdan = {
    isNormalUser = true;
    home = "/home/bogdan";
    extraGroups = ["wheel" "networkmanager" "video" "docker"];
  };

  virtualisation.docker.enable = true;

  services.tlp.enable = true;

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  system.stateVersion = "24.11";
}
