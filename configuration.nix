{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.timeout = 1;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "evillaptop";
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

  environment.systemPackages = with pkgs; [
    btop
    neovim
    wget
    xdg-desktop-portal-hyprland
    xdg-user-dirs
    zsh
  ];

  users.users.evilbunny = {
    isNormalUser = true;
    home = "/home/evilbunny";
    extraGroups = [ "wheel" "networkmanager" "video" ];
    packages = with pkgs; [
      alacritty
      bibata-cursors
      exa
      firefox
      fuzzel
      git
      glxinfo
      kdiff3
      lxappearance
      mako
      pavucontrol
      polkit_gnome
      papirus-icon-theme
      (python311.withPackages(ps: with ps; [ requests ]))
      ripgrep
      swaybg
      swaylock-effects
      unrar
      unzrip
      waybar
      wlogout
      wl-clipboard
      xfce.thunar
      xfce.thunar-archive-plugin
      xfce.tumbler
    ];
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

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  users.defaultUserShell = pkgs.zsh;
  environment.shells = [ pkgs.zsh ];

  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "man" ];
    };
  };

  programs.starship.enable = true;

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

