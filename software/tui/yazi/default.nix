# file: software/tui/yazi/default.nix

# #############################################################################
#
# Description:
# Aggregates yazi terminal file-manager.
#
# #############################################################################

{

  nixosModules = [

    ./nixos/yazi.nix

  ];

  hmModules = [

    ./home-manager/yazi.nix

  ];

}
