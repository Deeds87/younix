# file: software/gui/thunderbird/default.nix

# #############################################################################
#
# Description:
# Aggregates thunderbird email client.
#
# #############################################################################

{

  nixosModules = [ ];

  hmModules = [

    ./home-manager/thunderbird.nix

  ];

}
