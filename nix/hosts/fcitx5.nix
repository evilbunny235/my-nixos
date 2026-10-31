{ pkgs, ... }:
{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";

    fcitx5 = {
      waylandFrontend = true;
      addons = [
        pkgs.fcitx5-mozc
        pkgs.fcitx5-gtk
        pkgs.qt6Packages.fcitx5-chinese-addons
      ];
      settings.inputMethod = {
        GroupOrder = {
          "0" = "Default";
        };
        "Groups/0" = {
          "Name" = "Default";
          "Default Layout" = "us-dvorak";
          "Layout Option" = "caps:escape,altwin:menu_win";
          "DefaultIM" = "keyboard-us-dvorak";
        };
        "Groups/0/Items/0" = {
          "Name" = "keyboard-us-dvorak";
          "Layout" = "";
        };
        "Groups/0/Items/1" = {
          "Name" = "pinyin";
          "Layout" = "";
        };
      };
    };
  };

}
