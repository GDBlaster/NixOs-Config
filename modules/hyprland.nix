{
  lib,
  config,
  pkgs,
  ...
}:
{
  config = lib.mkIf (config.desktop == "hyprland") {

    environment.systemPackages = with pkgs; [
      kitty
      waybar
      dunst
      libnotify
      swww
      rofi-wayland
      xarchiver
      rofi-bluetooth
    ];

    programs.hyprland = {
      enable = true;
    };

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };

    programs.xfconf.enable = true;

    services.gvfs.enable = true;
    services.tumbler.enable = true;
    services.blueman.enable = true;

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time -r --asterisks --user-menu --cmd Hyprland";
          user = "greeter";
        };
      };
    };

    systemd.services.greetd = {
      serviceConfig.Type = "idle";
      unitConfig.After = ["docker.service" "nh-clean.service"];
    };

    systemd.services.numLockOnTty = {
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        # /run/current-system/sw/bin/setleds -D +num < "$tty";
        ExecStart = lib.mkForce (
          pkgs.writeShellScript "numLockOnTty" ''
            for tty in /dev/tty{1..6}; do
                ${pkgs.kbd}/bin/setleds -D +num < "$tty";
            done
          ''
        );
      };
    };

    security.pam.services.greetd.enableGnomeKeyring = true;

  };
}
