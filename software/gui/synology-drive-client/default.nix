# file: software/gui/synology-drive-client/default.nix

# #############################################################################
#
# Description:
# Aggregates synology drive client.
#
# #############################################################################

{

  nixosModules = [ ];

  hmModules = [

    ./home-manager/synology-drive-client.nix

  ];

}
