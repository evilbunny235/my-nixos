{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    timeout = 1;
    systemd-boot.configurationLimit = 10;
    efi.canTouchEfiVariables = true;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      nvidia-vaapi-driver
    ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  networking.hostName = "evilpc";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Amsterdam";

  i18n.defaultLocale = "en_IE.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "dvorak";
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  security.pam.services.swaylock.text = "auth include login";

  environment = { 
    systemPackages = with pkgs; [
      alacritty
      bibata-cursors
      btop
      exa
      firefox
      fuzzel
      glxinfo
      grim
      helix
      jq
      kdiff3
      kitty
      lxappearance
      mako
      nvtop
      pavucontrol
      polkit_gnome
      (python311.withPackages(ps: with ps; [ requests ]))
      ripgrep
      slurp
      swaybg
      swaylock-effects
      unrar
      unzrip
      waybar
      wget
      wlogout
      wl-clipboard
      xdg-desktop-portal-hyprland
      xdg-user-dirs
      xdg-utils

      (pkgs.writeShellApplication {
        name = "webcord";
	text = "${pkgs.webcord}/bin/webcord --disable-gpu";
      })
      (pkgs.makeDesktopItem {
        name = "webcord";
	exec = "webcord";
	desktopName = "WebCord";
      })
    ];
    shells = [ pkgs.zsh ];
    sessionVariables.NIXOS_OZONE_WL = "1";
    variables.EDITOR = "nvim";
  };

  users.defaultUserShell = pkgs.zsh;
  users.users.evilbunny = {
    isNormalUser = true;
    home = "/home/evilbunny";
    extraGroups = [ "wheel" "networkmanager" "video" ];
  };

  nixpkgs = {
    config.allowUnfree = true;
    
    overlays = [
      (self: super: {
        waybar = super.waybar.overrideAttrs (oldAttrs: {
	  mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
	});
      })
    ];
  };

  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" "Noto Color Emoji" ];
        sansSerif = [ "Noto Sans" "Noto Color Emoji" ];
        monospace = [ "Noto Sans" "MesloLGS NF" "Noto Color Emoji" ];
        emoji = [ "Noto Sans" "Noto Color Emoji" ];
      };
    };

    fonts = with pkgs; [
      meslo-lgs-nf
      fira-code
      dejavu_fonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
    ];
  };

  programs = { 
    git.enable = true;
    hyprland = {
      enable = true;
      nvidiaPatches = true;
      xwayland.enable = true;
    };

    neovim = {
      enable = true;
      defaultEditor = true;
    };
    
    starship.enable = true;
    steam.enable = true;

    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [ thunar-archive-plugin tumbler ];
    };

    zsh = {
      enable = true;
      autosuggestions.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
        enable = true;
        plugins = [ "git" "man" ];
      };
    };
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
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
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}

