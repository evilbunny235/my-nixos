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
      vt = 2;
      settings.default_session.user = "greeter";
    };

    blueman.enable = true;
    udisks2.enable = true;
    hypridle.enable = true;
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
      pkgs.ghostty
      pkgs.gtrash
      pkgs.helix
      pkgs.hyprpaper
      pkgs.kdiff3
      pkgs.meld
      pkgs.nil
      pkgs.nwg-look
      pkgs.pavucontrol
      pkgs.pinta
      pkgs.polkit_gnome
      pkgs.playerctl
      pkgs.ripgrep
      pkgs.sd
      pkgs.swaylock-effects
      pkgs.swaynotificationcenter
      pkgs.tealdeer
      pkgs.udiskie
      pkgs.unrar
      pkgs.unzip
      pkgs.vlc
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
      HIST_STAMPS = "%F %T";
    };

    shellAliases = {
      ip = "ip --color";
      ls = "eza --icons";
      tp = "gtrash put";
      trash_empty = "gtrash prune --day 7";
      k = "kubectl";
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
      pkgs.noto-fonts-cjk-sans
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

    lazygit = {
      enable = true;
      settings = {
        promptToReturnFromSubprocess = false;
        gui = {
          scrollHeight = 10;
          nerdFontsVersion = 3;
        };
        git.paging = {
          colorArg = "always";
          pager = "diff-so-fancy";
        };
      };
    };

    starship.enable = true;

    thunar = {
      enable = true;
      plugins = [
        pkgs.xfce.thunar-archive-plugin
        pkgs.xfce.tumbler
      ];
    };

    waybar.enable = true;

    zsh = {
      enable = true;
      histSize = 10000;
      autosuggestions.enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;

      setOptions = [
        "SHARE_HISTORY"
        "HIST_FCNTL_LOCK"
        "HIST_IGNORE_SPACE"
        "HIST_IGNORE_DUPS"
        "HIST_IGNORE_ALL_DUPS"
        "HIST_FIND_NO_DUPS"
        "HIST_SAVE_NO_DUPS"
      ];

      ohMyZsh = {
        enable = true;
        plugins = [
          "direnv"
          "fancy-ctrl-z"
          "fzf"
          "git"
          "man"
          "zoxide"
        ];
      };

      shellInit = ''
        FZF_DEFAULT_OPTS="--color=light"

        bindkey '^p' history-search-backward
        bindkey '^n' history-search-forward
      '';
    };

    direnv.enable = true;
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 7d --keep 3";
    };
  };

  xdg.portal = {
    enable = true;
  };

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;
    };
  };
}
