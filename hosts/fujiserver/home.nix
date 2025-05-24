{...}:
{
  imports = [
    ./../../modules/home-manager/users/paul.nix
  ];

  hmIsModule = false;
  desktop = "none";
  hm-autoupdate.enable = true;
}