# file: software/cli/dgop/default.nix

# #############################################################################
#
# Description:
# Dgop aggregator.
#
# #############################################################################

{

  nixosModules = [

    ./nixos/dgop.nix

  ];

  hmModules = [ ];

}
