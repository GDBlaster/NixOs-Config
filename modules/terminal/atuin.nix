{config, pkgs , ... }:

{
  environment.systemPackages = with pkgs; [
    atuin
  ];
  services.atuin.enable = true;
}