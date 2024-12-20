{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../common.nix
    ../../packages/scripts/screenshot.nix
  ];

  networking.hostName = "bogdan-nuc";

  environment = {
    systemPackages = [
      # aws and kubernetes stuff
      pkgs.awscli2
      pkgs.kubie
      pkgs.kubectl
      pkgs.openlens

      pkgs.helmfile
      (pkgs.wrapHelm pkgs.kubernetes-helm {
        plugins = [
          pkgs.kubernetes-helmPlugins.helm-diff
          pkgs.kubernetes-helmPlugins.helm-git
          pkgs.kubernetes-helmPlugins.helm-s3
          pkgs.kubernetes-helmPlugins.helm-secrets
        ];
      })

      pkgs.heaptrack
      pkgs.obs-studio
      pkgs.ranger
    ];
  };

  users.users.bogdan = {
    isNormalUser = true;
    home = "/home/bogdan";
    extraGroups = ["wheel" "networkmanager" "video" "docker"];
  };

  virtualisation.docker.enable = true;

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

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  networking.firewall.allowedUDPPorts = [30235];
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
