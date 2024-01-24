{pkgs, ...}: {
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    bluetooth.enable = true;
  };

  networking = {
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
      bemoji
      bibata-cursors
      btop
      eza
      diff-so-fancy
      firefox
      fuzzel
      fzf
      helix
      hyprpaper
      kdiff3
      kitty
      lazygit
      meld
      nil
      nomacs # basic image editor
      pavucontrol
      polkit_gnome
      playerctl
      ripgrep
      swaylock-effects
      swaynotificationcenter
      udiskie
      unrar
      unzip
      vlc
      waybar
      wlogout
      wl-clipboard
      wttrbar
      xdg-user-dirs
      xdg-utils
      zoxide
    ];

    shells = [pkgs.zsh];
    sessionVariables.NIXOS_OZONE_WL = "1";
    variables = {
      EDITOR = "hx";
      BEMOJI_PICKER_CMD = "fuzzel --dmenu";
    };
  };

  users = {
    defaultUserShell = pkgs.zsh;
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
        monospace = ["Fira Code" "MesloLGS NF" "Noto Color Emoji"];
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

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  nix = {
    settings.experimental-features = ["nix-command" "flakes"];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
}
