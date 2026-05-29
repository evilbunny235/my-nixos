{ pkgs, ... }:
let
  screenshot_area = pkgs.writeShellApplication {
    name = "screenshot_area";
    runtimeInputs = [
      pkgs.grim
      pkgs.slurp
      pkgs.satty
      pkgs.jq
    ];
    text = ''
      grim -g "$(slurp -b 00000055 -c 00000000)" - | satty -f - --output-filename "$HOME/Pictures/Screenshots/$(date '+%Y%m%d-%H:%M:%S').png"
    '';
  };

  screenshot_focused_window = pkgs.writeShellApplication {
    name = "screenshot_focused_window";
    runtimeInputs = [
      pkgs.jq
      pkgs.grim
      pkgs.satty
      pkgs.jq
    ];
    text = ''
      grim -g "$(hyprctl -j activewindow | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')" - | satty -f - --output-filename "$HOME/Pictures/Screenshots/$(date '+%Y%m%d-%H:%M:%S').png"
    '';
  };

  screenshot_focused_monitor = pkgs.writeShellApplication {
    name = "screenshot_focused_monitor";
    runtimeInputs = [
      pkgs.jq
      pkgs.grim
      pkgs.satty
      pkgs.jq
    ];
    text = ''
      grim -o "$(hyprctl -j monitors | jq -r '.[] | select(.focused) | .name')" - | satty -f - --output-filename "$HOME/Pictures/Screenshots/$(date '+%Y%m%d-%H:%M:%S').png"
    '';
  };

  toggle_tv = pkgs.writeShellApplication {
    name = "toggle_tv";
    runtimeInputs = [ pkgs.jq ];
    text = ''
      if [ "$1" == "true" ]; then
        hyprctl eval 'hl.monitor({ output = "HDMI-A-1", disabled = false })'
      else
        hyprctl eval 'hl.monitor({ output = "HDMI-A-1", disabled = true })'
      fi
    '';
  };

  toggle_hdr = pkgs.writeShellApplication {
    name = "toggle_hdr";
    runtimeInputs = [ pkgs.jq ];
    text = ''
      if [ "$1" == "true" ]; then
        hyprctl eval 'hl.monitor({ output = "DP-1", bitdepth = 10, cm = "hdr" })'
      else
        hyprctl eval 'hl.monitor({ output = "DP-1", bitdepth = 8, cm = "srgb" })'
      fi
    '';
  };
in
{
  environment.systemPackages = [
    screenshot_area
    screenshot_focused_window
    screenshot_focused_monitor

    toggle_tv
    toggle_hdr
  ];
}
