{ config, pkgs, ... }:
{
  # Generate the hardware-configuration.nix file as a separate derivation
  config.system.build.hardware-configuration =
    pkgs.runCommand "hardware-configuration.nix"
      {
        nativeBuildInputs = [ pkgs.nixos-generate-config ];
      }
      ''
        # Generate the hardware-configuration.nix file
        nixos-generate-config --dir $out
      '';
}
