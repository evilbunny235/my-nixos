{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../common.nix
    ../hyprland-scripts.nix
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
      pkgs.beekeeper-studio
      pkgs.brightnessctl
      pkgs.heaptrack
      pkgs.libreoffice-fresh
      pkgs.pgadmin4-desktopmode
      pkgs.tcpdump
      pkgs.tokio-console
      pkgs.vesktop
      pkgs.wireshark
    ];
  };

  nixpkgs.config.permittedInsecurePackages = [
    "beekeeper-studio-5.3.4"
  ];

  programs.wireshark.enable = true;

  users.users.bogdan = {
    isNormalUser = true;
    home = "/home/bogdan";
    extraGroups = ["wheel" "networkmanager" "video" "docker" "wireshark"];
  };

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_17;
    enableTCPIP = true;
    extensions = ps: [
      ps.pg_cron
    ];

    settings = {
      shared_preload_libraries = "pg_cron";
      "cron.database_name" = "postgres";
    };
    
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
  networking.firewall.allowedTCPPorts = [
    config.services.postgresql.settings.port
    config.services.jupyter.port
  ];

  security.pki.certificateFiles = [../../../certificates/aws-global-bundle.pem];

  system.stateVersion = "24.11";
}
