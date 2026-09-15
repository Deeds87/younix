# file: software/gui/dankcalendar/default.nix

# #############################################################################
#
# Description:
# Dankcalendar aggregator.
#
# #############################################################################

{

  nixosModules = [ ];

  hmModules = [

    ./home-manager/dankcalendar.nix

  ];

}
