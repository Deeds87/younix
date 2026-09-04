# file: environments/desktops/kde/default.nix

# #############################################################################
#
# Description:
# Aggregates KDE Plasma desktop.
#
# #############################################################################

{

  nixosModules = [

    ./nixos/kde.nix

  ];

  hmModules = [ ];

}
