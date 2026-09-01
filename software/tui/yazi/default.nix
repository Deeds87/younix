# file: software/tui/yazi/default.nix

# #############################################################################
#
# Description:
# Aggregates yazi terminal file-manager.
#
# #############################################################################

{

  nixosModules = [ ];

  hmModules = [

    ./home-manager/yazi.nix

  ];

}
