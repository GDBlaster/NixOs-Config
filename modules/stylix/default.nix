{ lib, ... }:
{
  options = {
    ui.theme = lib.mkOption {
      type = lib.types.enum [
        "kirby"
        "nixos"
        "entergalactic"
      ];
      default = "kirby";
      description = "Select theme. Options: kirby, nixos, entergalactic";
    };
  };

  config.stylix.enable = true;

  imports = [
    ./themes/nixos.nix
    ./themes/kirby.nix
    ./themes/entergalactic.nix
  ];
}

# base00 = #2B213C
# base01 = #362B48
# base02 = #4D4160
# base03 = #655978
# base04 = #7F7192
# base05 = #998BAD
# base06=  #B4A5C8
# base07 = #EBDCFF
# base08 = #C79987
# base09 = #8865C6
# base0A = #C7C691
# base0B = #ACC79B
# base0C = #9BC7BF
# base0D = #A5AAD4
# base0E = #C594FF
# base0F = #C7AB87
