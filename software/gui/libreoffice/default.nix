# file: software/gui/libreoffice/default.nix

# #############################################################################
#
# Description:
# Aggregates libreoffice office suite.
#
# #############################################################################

{

  nixosModules = [ ];

  hmModules = [

    ./home-manager/libreoffice.nix

  ];

}
