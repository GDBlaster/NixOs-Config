{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.services.remoteBuild.host.enable {
    users.users.builder = {
      isSystemUser = true;
      createHome = true;
      homeDirectory = "/var/lib/builder";
      shell = pkgs.nologin;
      description = "Nix remote builder account";
      openssh.authorizedKeys.keys = [];
    };
  };
}
