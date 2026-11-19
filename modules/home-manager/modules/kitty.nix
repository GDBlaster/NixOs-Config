{ lib, ... }:
{
  programs.kitty = {
    enable = true;
    settings = lib.mkForce {
      background_opacity = 0.8;
      background_blur = 1;
      enable_audio_bell = false;
    };
    keybindings = {
      f1 = "launch --type=os-window --cwd=current";

      scroll_lock = ''send_text all \x1b'';
    };
  };

}
