{...}:
{
  wayland.windowManager.hyprland = {
    enable = true;

    # use packages from nixpkgs
    package = null;
    portalPackage = null;
  };
  programs.kitty.enable = true;

}