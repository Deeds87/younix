# file: environments/display-manager/gdm/default.nix

# #############################################################################
#
# Description:
# Aggregates GDM display manager.
#
# #############################################################################

{

  nixosModules = [

    ./nixos/gdm.nix

  ];

  hmModules = [ ];

}
