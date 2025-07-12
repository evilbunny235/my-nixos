{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../common.nix
    ../../packages/scripts/screenshot.nix
    ../../packages/scripts/tv.nix
  ];

  hardware.xone.enable = true;
  networking.hostName = "evilpc";

  environment = {
    systemPackages = [
      pkgs.anki-bin
      pkgs.amdgpu_top
      pkgs.gimp
      pkgs.headsetcontrol
      pkgs.helvum
      pkgs.qpwgraph
      pkgs.kdePackages.kdenlive
      pkgs.lutris
      pkgs.mangohud
      pkgs.path-of-building
      pkgs.prismlauncher
      pkgs.qbittorrent
      pkgs.deluge
      pkgs.vesktop
      pkgs.wine64

      pkgs.jellyfin
      pkgs.jellyfin-web
      pkgs.jellyfin-ffmpeg

      pkgs.kubectl
      pkgs.kubernetes-helm
      pkgs.minikube
      pkgs.dive
    ];
  };

  services.udev.packages = [pkgs.headsetcontrol];

  users.users.evilbunny = {
    isNormalUser = true;
    home = "/home/evilbunny";
    extraGroups = ["wheel" "networkmanager" "video" "docker"];
  };

  services.greetd.settings.default_session.command = ''
    ${pkgs.greetd.tuigreet}/bin/tuigreet --time -r --user-menu --cmd "Hyprland -c ~/.config/hypr/hyprland_evilpc.conf"
  '';

  # virtualisation.docker.enable = true;

  programs = {
    steam.enable = true;
    obs-studio = {
      enable = true;
      plugins = [ pkgs.obs-studio-plugins.obs-vaapi ];
    };
  };

  services.mysql = {
    enable = true;
    package = pkgs.mysql84;
  };

  systemd.services.mysql.wantedBy = pkgs.lib.mkForce [];

  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "evilbunny";
  };

  # services.printing = {
  #   enable = true;
  #   drivers = [pkgs.cnijfilter2];
  # };
  # services.avahi = {
  #   enable = true;
  #   nssmdns4 = true;
  #   openFirewall = true;
  #   publish = {
  #     enable = true;
  #     userServices = true;
  #   };
  # };

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  system.stateVersion = "23.05";
}
