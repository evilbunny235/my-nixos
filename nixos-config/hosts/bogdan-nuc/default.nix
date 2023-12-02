{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../packages/scripts/screenshot.nix
  ];

  boot.loader = {
    systemd-boot = {
      enable = true;
      editor = false;
      configurationLimit = 10;
    };

    timeout = 1;
    efi.canTouchEfiVariables = true;
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    bluetooth.enable = true;
  };

  networking = {
    hostName = "bogdan-nuc";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Amsterdam";

  i18n.defaultLocale = "en_IE.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "dvorak";
  };

  services = {
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    blueman.enable = true;
    udisks2.enable = true;
  };

  security.pam.services.swaylock.text = "auth include login";

  environment = {
    systemPackages = with pkgs; [
      bibata-cursors
      btop
      eza
      firefox
      fuzzel
      helix
      kdiff3
      kitty
      lazygit
      mako
      meld # merge tool
      nil
      nomacs # basic image editor
      obs-studio
      pavucontrol
      polkit_gnome
      playerctl
      ranger
      ripgrep
      swaybg
      swaylock-effects
      unrar
      unzip
      vlc
      waybar
      wget
      wlogout
      wl-clipboard
      xdg-desktop-portal-hyprland
      xdg-user-dirs
      xdg-utils
    ];

    shells = [pkgs.zsh];
    sessionVariables.NIXOS_OZONE_WL = "1";
    variables.EDITOR = "hx";
  };

  users = {
    defaultUserShell = pkgs.zsh;
    users.bogdan = {
      isNormalUser = true;
      home = "/home/bogdan";
      extraGroups = ["wheel" "networkmanager" "video"];
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
  };

  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = ["Noto Serif" "Noto Color Emoji"];
        sansSerif = ["Noto Sans" "Noto Color Emoji"];
        monospace = ["Noto Sans" "Fira Code" "MesloLGS NF" "Noto Color Emoji"];
        emoji = ["Noto Sans" "Noto Color Emoji"];
      };
    };

    packages = with pkgs; [
      dejavu_fonts
      fira-code
      meslo-lgs-nf
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
    ];
  };

  programs = {
    git.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    starship.enable = true;

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [thunar-archive-plugin tumbler];
    };

    zsh = {
      enable = true;
      autosuggestions.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
        enable = true;
        plugins = ["git" "man"];
      };
    };

    direnv.enable = true;
  };

  nix = {
    settings.experimental-features = ["nix-command" "flakes"];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
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
