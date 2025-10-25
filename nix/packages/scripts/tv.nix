{pkgs, ...}: {
  environment.systemPackages = let
    enable_tv = pkgs.writeShellApplication {
      name = "enable_tv";
      runtimeInputs = [];
      text = ''
        hyprctl keyword monitor HDMI-A-1, 3840x2160@60.00, 5120x0, 1
      '';
    };
    disable_tv = pkgs.writeShellApplication {
      name = "disable_tv";
      runtimeInputs = [];
      text = ''
        hyprctl keyword monitor HDMI-A-1, disabled
      '';
    };
  in [
    enable_tv
    disable_tv
  ];
}
