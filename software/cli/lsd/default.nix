# file: software/cli/lsd/default.nix

# #############################################################################
#
# Description:
# Aggregates lsd, a modern ls alternative.
#
# #############################################################################

{

  nixosModules = [ ];

  hmModules = [

    ./home-manager/lsd.nix

  ];

}
