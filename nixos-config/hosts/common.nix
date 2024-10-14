{pkgs, ...}: {
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

  hardware = {
    graphics = {
      enable = true;
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

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time -r --user-menu --cmd Hyprland";
          user = "greeter";
        };
      };
    };

    blueman.enable = true;
    udisks2.enable = true;
  };

  security.pam.services.swaylock.text = "auth include login";

  environment = {
    systemPackages = [
      pkgs.bemoji
      pkgs.bibata-cursors
      pkgs.btop
      pkgs.eza
      pkgs.diff-so-fancy
      pkgs.firefox
      pkgs.fuzzel
      pkgs.fzf
      pkgs.helix
      pkgs.hyprpaper
      pkgs.kdiff3
      pkgs.kitty
      pkgs.lazygit
      pkgs.meld
      pkgs.nil
      pkgs.nomacs # basic image editor
      pkgs.pavucontrol
      pkgs.polkit_gnome
      pkgs.playerctl
      pkgs.ripgrep
      pkgs.sd
      pkgs.swaylock-effects
      pkgs.swaynotificationcenter
      pkgs.tldr
      pkgs.udiskie
      pkgs.unrar
      pkgs.unzip
      pkgs.vlc
      pkgs.waybar
      pkgs.wlogout
      pkgs.wl-clipboard
      pkgs.wttrbar
      pkgs.xdg-user-dirs
      pkgs.xdg-utils
      pkgs.zoxide
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

    packages = [
      pkgs.dejavu_fonts
      pkgs.fira-code
      pkgs.meslo-lgs-nf
      pkgs.noto-fonts
      pkgs.noto-fonts-cjk
      pkgs.noto-fonts-emoji
    ];
  };

  programs = {
    file-roller.enable = true;
    git.enable = true;
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    starship.enable = true;

    thunar = {
      enable = true;
      plugins = [
        pkgs.xfce.thunar-archive-plugin
        pkgs.xfce.tumbler
      ];
    };

    zsh = {
      enable = true;
      autosuggestions.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
        enable = true;
        plugins = [
          "direnv"
          "fancy-ctrl-z"
          "git"
          "man"
        ];
      };
    };

    direnv.enable = true;
  };

  xdg.portal = {
    enable = true;
  };

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;
    };
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };
}
