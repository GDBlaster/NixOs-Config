{
  config,
  lib,
  pkgs,
  ...
}:
{
  config = lib.mkIf config.services.remoteBuild.host.enable {
    users = {
      users.builder = {
        isSystemUser = true;
        createHome = true;
        home = "/var/lib/builder";
        shell = pkgs.zsh;
        description = "Nix remote builder account";
        openssh.authorizedKeys.keys = config.services.remoteBuild.clientKeys;
        group = "builder";
      };
      groups.builder = { };
    };
  };
}
