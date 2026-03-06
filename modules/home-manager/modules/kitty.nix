{ lib, ... }:
{
  programs.kitty = {
    enable = true;
    settings = lib.mkForce {
      background_opacity = 0.8;
      background_blur = 1;
    };
    keybindings = {
      f1 = "launch --type=os-window --cwd=current";
    };
  };

}
