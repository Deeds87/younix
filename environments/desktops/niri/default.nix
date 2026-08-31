# file: environments/desktops/niri/default.nix

# #############################################################################
#
# Description:
# Aggregates niri window-manager.
#
# #############################################################################

{

  nixosModules = [

    ./nixos/niri.nix

  ];

  hmModules = [

    ./home-manager/niri.nix

  ];

}
