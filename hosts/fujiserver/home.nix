{...}:
{
  imports = [
    ./../../modules/home-manager/users
    ./../../modules/home-manager/users/paul.nix
  ];

  hmIsModule = false;
  desktop = "none";
}