{config, nixpkgs , ... }:

{
  environment.systemPackages = with nixpkgs; [
    atuin
  ];
  services.atuin.enable = true;
}