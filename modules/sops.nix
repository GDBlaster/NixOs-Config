{ lib, config, ... }:
{
  options = {
    sops.enable = lib.mkEnableOption "sops-nix support";
  };

  config = lib.mkIf (config.sops.enable) {

    services.openssh.generateHostKeys = true;

    sops = {
      defaultSopsFile = ../secrets/shared.yaml;
      age = {
        sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
        keyFile = "/var/lib/sops-nix/key.txt";
        generateKey = true;
      };

    };
  };
}
