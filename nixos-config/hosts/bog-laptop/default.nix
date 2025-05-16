{pkgs, ...}: let
  postgresql_port = 5432;
  keydb_port = 6379;
in {
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
      pkgs.brightnessctl
      pkgs.beekeeper-studio
      pkgs.heaptrack
      pkgs.jq
      pkgs.keydb
      pkgs.tcpdump
      pkgs.tokio-console
      pkgs.vesktop
      pkgs.wireshark
    ];
  };

  nixpkgs.config.permittedInsecurePackages = [
    "beekeeper-studio-5.1.5"
  ];

  programs = {
    wireshark.enable = true;
  };

  users.users.bogdan = {
    isNormalUser = true;
    home = "/home/bogdan";
    extraGroups = ["wheel" "networkmanager" "video" "docker" "wireshark"];
  };

  services.greetd.settings.default_session.command = ''
    ${pkgs.greetd.tuigreet}/bin/tuigreet --time -r --user-menu --cmd "Hyprland -c ~/.config/hypr/hyprland_bog-laptop.conf"
  '';

  virtualisation.docker.enable = false;

  services.tlp = {
    enable = true;

    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 80;
    };
  };

  services.postgresql = {
    enable = true;
    enableTCPIP = true;
    settings.port = postgresql_port;
    authentication = pkgs.lib.mkOverride 10 ''
      # type database DBuser origin-address auth-method
      local  all      all     trust

      # ipv4
      host   all      all     10.0.100.0/24   trust
      # ipv6
      host   all      all     ::1/128         trust
    '';
  };

  networking.firewall.checkReversePath = false;
  networking.firewall.allowedTCPPorts = [postgresql_port keydb_port];
  # networking.firewall.allowedUDPPorts = [ ... ];

  system.stateVersion = "24.11";
}
