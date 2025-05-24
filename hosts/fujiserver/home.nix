{...}:
{
  imports = [
    ./../../modules/home-manager/users/paul.nix
  ];

  hmIsModule = false;
  desktop = "none";
  services.hm-autoupdate.enable = true;
}