{pkgs, ...}: let
  screenshot_area = pkgs.writeShellApplication {
    name = "screenshot_area";
    runtimeInputs = [pkgs.grim pkgs.slurp pkgs.satty pkgs.jq];
    text = ''
      grim -g "$(slurp -b 00000055 -c 00000000)" - | satty -f - --output-filename "$HOME/Pictures/Screenshots/$(date '+%Y%m%d-%H:%M:%S').png"
    '';
  };

  screenshot_focused_window = pkgs.writeShellApplication {
    name = "screenshot_focused_window";
    runtimeInputs = [pkgs.jq pkgs.grim pkgs.satty pkgs.jq];
    text = ''
      grim -g "$(hyprctl -j activewindow | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')" - | satty -f - --output-filename "$HOME/Pictures/Screenshots/$(date '+%Y%m%d-%H:%M:%S').png"
    '';
  };

  screenshot_focused_monitor = pkgs.writeShellApplication {
    name = "screenshot_focused_monitor";
    runtimeInputs = [pkgs.jq pkgs.grim pkgs.satty pkgs.jq];
    text = ''
      grim -o "$(hyprctl -j monitors | jq -r '.[] | select(.focused) | .name')" - | satty -f - --output-filename "$HOME/Pictures/Screenshots/$(date '+%Y%m%d-%H:%M:%S').png"
    '';
  };

  toggle_tv = pkgs.writeShellApplication {
    name = "toggle_tv";
    runtimeInputs = [pkgs.jq];
    text = ''
      if [ "$1" == "true" ]; then
        hyprctl keyword monitor HDMI-A-1, 3840x2160@60.00, 5120x0, 1
      else
        hyprctl keyword monitor HDMI-A-1, disabled
      fi
    '';
  };

  is_tv_on = pkgs.writeShellApplication {
    name = "is_tv_on";
    runtimeInputs = [pkgs.jq];
    text = ''
      hyprctl -j monitors | jq -r 'any(.[]; .name == "HDMI-A-1")'
    '';
  };

  toggle_hdr = pkgs.writeShellApplication {
    name = "toggle_hdr";
    runtimeInputs = [pkgs.jq];
    text = ''
      if [ "$1" == "true" ]; then
        hyprctl keyword monitor DP-1, 2560x1440@164.84, 0x0,1, vrr, 1, bitdepth, 10, cm, hdr, sdrbrightness, 1.1
      else
        hyprctl keyword monitor DP-1, 2560x1440@164.84, 0x0,1, vrr, 1
      fi
    '';
  };

  is_hdr_on = pkgs.writeShellApplication {
    name = "is_hdr_on";
    runtimeInputs = [pkgs.jq];
    text = ''
      hyprctl -j monitors | jq -r '.[] | select (.model == "MAG274QRF-QD") | .colorManagementPreset == "hdr"'
    '';
  };
in {
  environment.systemPackages = [
    screenshot_area
    screenshot_focused_window
    screenshot_focused_monitor

    toggle_tv
    is_tv_on

    toggle_hdr
    is_hdr_on
  ];
}
