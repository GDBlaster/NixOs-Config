{
  config,
  lib,
  pkgs,
  ...
}:
{

  config = lib.mkIf config.users.paul.enable {

    users.users.paul = {
      isNormalUser = true;
      description = "Paul";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
        "borg"
      ];
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMJMLS/zHTcw43m3pxj5mt2Q9Rm76zDMsLU7YQ5GZkLC paul@nixos-laptop"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIFeLDbkDuXQUTCK0HTBEmKM/2Tg77x9vz7UCX12UYBO paul@DESKTOP-SPT4TVG"
      ];
    };
  };
}
