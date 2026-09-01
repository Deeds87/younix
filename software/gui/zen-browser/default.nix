# file: software/gui/zen-browser/default.nix

# #############################################################################
#
# Description:
# Aggregates zen-browser.
#
# #############################################################################

{

  nixosModules = [ ];

  hmModules = [

    ./home-manager/zen-browser.nix

  ];

}
