# file: software/gui/kitty/default.nix

# #############################################################################
#
# Description:
# Aggregates kitty terminal emulator.
#
# #############################################################################

{

  nixosModules = [ ];

  hmModules = [

    ./home-manager/kitty.nix

  ];

}
