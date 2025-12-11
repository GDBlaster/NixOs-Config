# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  #inputs,
  #config,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./../../modules
    ./../../modules/home-manager
    ./../../modules/stylix/stylix.nix
  ];

  networking.hostName = "nixos-vm"; # Define your hostname.

  nix.settings = {
    # To change when on a real host
    cores = 2;
    max-jobs = 4;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.zsh.enable = true;
  users.users.paul = {
    password = "cheese";
    isNormalUser = true;
    description = "Paul";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
    # packages = with pkgs; [ ];
  };

  desktop = "none";

  stacks."mc-1.21.5".enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  virtualisation.vmVariant = {
    virtualisation = {
      vmware.guest.enable = true;
      memorySize = 4096;
      cores = 4;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
