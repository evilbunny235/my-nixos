{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../common.nix
    ../../packages/scripts/screenshot.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
        configurationLimit = 5;
      };

      timeout = 1;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
  };

  hardware.xone.enable = true;
  networking.hostName = "evilpc";

  environment = {
    systemPackages = [
      pkgs.amdgpu_top
      pkgs.gimp
      pkgs.helvum
      pkgs.qpwgraph
      pkgs.lutris
      pkgs.obs-studio
      pkgs.path-of-building
      pkgs.prismlauncher
      pkgs.qbittorrent
      pkgs.vesktop
      pkgs.wine64
    ];
  };

  users.users.evilbunny = {
    isNormalUser = true;
    home = "/home/evilbunny";
    extraGroups = ["wheel" "networkmanager" "video"];
  };

  programs = {
    steam.enable = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time -r --user-menu --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  services.mysql = {
    enable = true;
    package = pkgs.mysql84;
  };

  systemd.services.mysql.wantedBy = pkgs.lib.mkForce [];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ 30235 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
