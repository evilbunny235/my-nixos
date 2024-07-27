{pkgs, ...}: {
  environment.systemPackages = let
    screenshot_area = pkgs.writeShellApplication {
      name = "screenshot_area";
      runtimeInputs = with pkgs; [grim slurp satty];
      text = ''
        grim -g "$(slurp -b 00000055 -c 00000000)" - | satty -f -
      '';
    };

    screenshot_focused_window = pkgs.writeShellApplication {
      name = "screenshot_focused_window";
      runtimeInputs = with pkgs; [jq grim satty];
      text = ''
        grim -g "$(hyprctl -j activewindow | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')" - | satty -f -
      '';
    };

    screenshot_focused_monitor = pkgs.writeShellApplication {
      name = "screenshot_focused_monitor";
      runtimeInputs = with pkgs; [jq grim satty];
      text = ''
        grim -o "$(hyprctl -j monitors | jq -r '.[] | select(.focused) | .name')" - | satty -f -
      '';
    };
  in [
    screenshot_area
    screenshot_focused_window
    screenshot_focused_monitor
  ];
}
