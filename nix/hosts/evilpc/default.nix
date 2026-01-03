{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../common.nix
    ../hyprland-scripts.nix
  ];

  nixpkgs.overlays = [
    (final: prev: {
      xow_dongle-firmware = prev.xow_dongle-firmware.overrideAttrs (old: {
        version = "0-unstable-2025-12-18";

        srcs = [
          (prev.fetchurl {
            url = "https://catalog.s.download.windowsupdate.com/d/msdownload/update/driver/drvs/2017/03/2ea9591b-f751-442c-80ce-8f4692cdc67b_6b555a3a288153cf04aec6e03cba360afe2fce34.cab";
            hash = "sha256-2Jpy6NwQt8TxbVyIf+f1TDTCIAWsHzYHBNXZRiJY7zI=";
          })
          (prev.fetchurl {
            url = "https://catalog.s.download.windowsupdate.com/c/msdownload/update/driver/drvs/2017/07/1cd6a87c-623f-4407-a52d-c31be49e925c_e19f60808bdcbfbd3c3df6be3e71ffc52e43261e.cab";
            hash = "sha256-ZXNqhP9ANmRbj47GAr7ZGrY1MBnJyzIz3sq5/uwPbwQ=";
          })
          (prev.fetchurl {
            url = "https://catalog.s.download.windowsupdate.com/c/msdownload/update/driver/drvs/2017/06/1dbd7cb4-53bc-4857-a5b0-5955c8acaf71_9081931e7d664429a93ffda0db41b7545b7ac257.cab";
            hash = "sha256-kN2R+2dGDTh0B/2BCcDn0PGPS2Wb4PYtuFihhJ6tLuA=";
          })
          (prev.fetchurl {
            url = "https://catalog.s.download.windowsupdate.com/d/msdownload/update/driver/drvs/2017/08/aeff215c-3bc4-4d36-a3ea-e14bfa8fa9d2_e58550c4f74a27e51e5cb6868b10ff633fa77164.cab";
            hash = "sha256-Wo+62VIeWMxpeoc0cgykl2cwmAItYdkaiL5DMALM2PI=";
          })
        ];

        unpackPhase = ''
          srcs=($srcs)
          cabextract -F FW_ACC_00U.bin ''${srcs[0]}
          mv FW_ACC_00U.bin xone_dongle_02e6.bin
          cabextract -F FW_ACC_00U.bin ''${srcs[1]}
          mv FW_ACC_00U.bin xone_dongle_02fe.bin
          cabextract -F FW_ACC_CL.bin ''${srcs[2]}
          mv FW_ACC_CL.bin xone_dongle_02f9.bin
          cabextract -F FW_ACC_BR.bin ''${srcs[3]}
          mv FW_ACC_BR.bin xone_dongle_091e.bin
        '';

        installPhase = ''
          mkdir -p $out/lib/firmware/
          cp xone_dongle_*.bin $out/lib/firmware/
        '';
      });
    })
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
      pkgs.rusty-path-of-building
      pkgs.prismlauncher
      pkgs.qbittorrent
      pkgs.deluge
      pkgs.vesktop
      pkgs.wine64

      pkgs.jellyfin
      pkgs.jellyfin-web
      pkgs.jellyfin-ffmpeg
    ];
  };

  services.udev.packages = [pkgs.headsetcontrol];

  users.users.evilbunny = {
    isNormalUser = true;
    home = "/home/evilbunny";
    extraGroups = ["wheel" "networkmanager" "video" "docker"];
  };

  services.greetd.settings.default_session.command = ''
    ${pkgs.tuigreet}/bin/tuigreet --time -r --user-menu --cmd "Hyprland -c ~/.config/hypr/hyprland_evilpc.conf"
  '';

  programs = {
    steam.enable = true;
    obs-studio = {
      enable = true;
      plugins = [pkgs.obs-studio-plugins.obs-vaapi];
    };

    dms-shell = {
      enable = true;
      enableClipboard = true;
      enableDynamicTheming = true;
      enableSystemMonitoring = true;

      systemd = {
        enable = true;
        restartIfChanged = true;
      };
    };
  };

  systemd.user.targets = {
    "hyprland-session" = {
      bindsTo = ["graphical-session.target"];
      after = ["graphical-session.target"];
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
