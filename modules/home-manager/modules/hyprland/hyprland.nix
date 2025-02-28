{...}:
{
  wayland.windowManager.hyprland = {
    # enable = true;
    
    settings = {
      "$mod" = "SUPER";
      binds = [
        "$mod, Q, exec, kitty"
      ];
    };
  };
  programs.kitty.enable = true;

}