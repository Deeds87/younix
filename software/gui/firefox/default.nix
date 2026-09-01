# file: software/gui/firefox/default.nix

# #############################################################################
#
# Description:
# Aggregates firefox internet browser.
#
# #############################################################################

{

  nixosModules = [ ];

  hmModules = [

    ./home-manager/firefox.nix

  ];

}
