{
  config,
  lib,
  pkgs,
  ...
}:
{

  config = lib.mkIf config.users.famille.enable {

    users.users.famille = {
      isNormalUser = true;
      description = "Famille";
      extraGroups = [
        "networkmanager"
        "borg"
      ];
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
      ];
    };
  };
}
