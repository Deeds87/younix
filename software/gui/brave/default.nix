# file: software/gui/brave/default.nix

# #############################################################################
#
# Description:
# Aggregates brave browser.
#
# #############################################################################

{

  nixosModules = [ ];

  hmModules = [

    ./home-manager/brave.nix

  ];

}
