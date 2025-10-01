{pkgs, ...}: let
  postgresql_port = 5432;
  keydb_port = 6379;
in {
  imports = [
    ./hardware-configuration.nix
    ../common.nix
    ../../packages/scripts/screenshot.nix
  ];

  networking.hostName = "bog-laptop";

  hardware = {
    tuxedo-rs = {
      enable = true;
      tailor-gui.enable = true;
    };
  };

  environment = {
    systemPackages = [
      pkgs.awscli2
      pkgs.brightnessctl
      pkgs.beekeeper-studio
      pkgs.heaptrack
      pkgs.jq
      pkgs.keydb
      pkgs.libreoffice-fresh
      pkgs.tcpdump
      pkgs.tokio-console
      pkgs.vesktop
      pkgs.wireshark
    ];
  };

  nixpkgs.config.permittedInsecurePackages = [
    "beekeeper-studio-5.2.12"
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
    ${pkgs.tuigreet}/bin/tuigreet --time -r --user-menu --cmd "Hyprland -c ~/.config/hypr/hyprland_bog-laptop.conf"
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
    };
  };

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_17;
    enableTCPIP = true;
    settings.port = postgresql_port;
    authentication = pkgs.lib.mkOverride 10 ''
      # type database DBuser origin-address auth-method
      local  all      all     trust

      # ipv4
      host   all      all     all   trust
      # ipv6
      host   all      all     ::1/128         trust
    '';
  };

  services.openssh = {
    enable = true;
    settings = {
      AllowUsers = ["bogdan"];
    };
  };

  networking.firewall.checkReversePath = false;
  networking.firewall.allowedTCPPorts = [postgresql_port keydb_port];
  # networking.firewall.allowedUDPPorts = [ ... ];

  system.stateVersion = "24.11";
}
