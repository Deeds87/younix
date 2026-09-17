# file: software/tui/nixvim/default.nix

# #############################################################################
#
# Description:
# Nixvim aggregator.
#
# #############################################################################

{

  nixosModules = [ ];

  hmModules = [

    ./home-manager/nixvim.nix

  ];
}
