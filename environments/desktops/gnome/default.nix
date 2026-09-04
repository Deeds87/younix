# file: environemts/desktops/gnome/default.nix

# #############################################################################
#
# Description:
# Aggregates GNOME desktop.
#
# #############################################################################

{

  nixosModules = [

    ./nixos/gnome.nix

  ];

  hmModules = [ ];

}
