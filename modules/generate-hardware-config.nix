{ config, pkgs, ... }:
{
  # Generate the hardware-configuration.nix file
  config.system.build.hardware-configuration =
    pkgs.runCommand "hardware-configuration.nix"
      {
        # Ensure nixos-generate-config is available
        nativeBuildInputs = [ pkgs.nixos-generate-config ];
      }
      ''
        # Generate the hardware-configuration.nix file
        nixos-generate-config --dir $out
      '';

  # Import the generated hardware-configuration.nix file
  config.imports = [ config.system.build.hardware-configuration ];
}
