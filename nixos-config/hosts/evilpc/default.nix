{pkgs, ...}: {
  imports = [
    ./hardware-configuration.nix
    ../common.nix
    ../../packages/scripts/screenshot.nix
  ];

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      # systemd-boot = {
      #   enable = true;
      #   editor = false;
      #   configurationLimit = 10;
      # };

      timeout = 1;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };

      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        configurationLimit = 10;
        extraEntries = ''
          menuentry "Windows" {
            insmod part_gpt
            insmod fat
            insmod search_fs_uuid
            insmod chain
            search --fs-uuid --set=root $FS_UUID
            chainloader /EFI/Microsoft/Boot/bootmgfw.efi
          }
        '';
      };
    };
  };

  hardware.xone.enable = true;
  networking.hostName = "evilpc";

  environment = {
    systemPackages = with pkgs; [
      amdgpu_top
      armcord
      helvum
      path-of-building
      qbittorrent
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
