{pkgs, ...}: let
  screenshot_area = pkgs.writeShellApplication {
    name = "screenshot_area";
    runtimeInputs = with pkgs; [grim slurp satty];
    text = ''
      grim -g "$(slurp -b 00000055 -c 00000000)" - | satty -f - --output-filename "$HOME/Pictures/Screenshots/$(date '+%Y%m%d-%H:%M:%S').png"
    '';
  };

  screenshot_focused_window = pkgs.writeShellApplication {
    name = "screenshot_focused_window";
    runtimeInputs = with pkgs; [jq grim satty];
    text = ''
      grim -g "$(hyprctl -j activewindow | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')" - | satty -f - --output-filename "$HOME/Pictures/Screenshots/$(date '+%Y%m%d-%H:%M:%S').png"
    '';
  };

  screenshot_focused_monitor = pkgs.writeShellApplication {
    name = "screenshot_focused_monitor";
    runtimeInputs = with pkgs; [jq grim satty];
    text = ''
      grim -o "$(hyprctl -j monitors | jq -r '.[] | select(.focused) | .name')" - | satty -f - --output-filename "$HOME/Pictures/Screenshots/$(date '+%Y%m%d-%H:%M:%S').png"
    '';
  };

  toggle_tv = pkgs.writeShellApplication {
    name = "toggle_tv";
    runtimeInputs = [];
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
    runtimeInputs = [];
    text = ''
      hyprctl -j monitors | jq -r 'any(.[]; .name == "HDMI-A-1")'
    '';
  };
in {
  environment.systemPackages = [
    screenshot_area
    screenshot_focused_window
    screenshot_focused_monitor
    toggle_tv
    is_tv_on
  ];
}
