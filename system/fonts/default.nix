# file: system/fonts/default.nix

# #############################################################################
#
# Description:
# Aggregates fonts.
#
# #############################################################################

{

  nixosModules = [

    ./nixos/fonts.nix

  ];

  home-manager = [ ];

}
