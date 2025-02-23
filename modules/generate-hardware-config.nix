{ config, pkgs, ... }:
{
  options = {
    system.build.hardware-configuration = pkgs.lib.mkOption {
      type = pkgs.lib.types.package;
      description = "The generated hardware-configuration.nix file";
    };
  };

  config = {
    # Generate the hardware-configuration.nix file dynamically
    system.build.hardware-configuration =
      pkgs.runCommand "hardware-configuration.nix"
        {
          nativeBuildInputs = [ pkgs.nixos-generate-config ];
        }
        ''
          # Generate the hardware-configuration.nix file
          nixos-generate-config --dir $out
        '';
  };
}
