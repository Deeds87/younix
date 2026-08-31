# file: environments/desktop-shells/dms/default.nix

# #############################################################################
#
# Description:
# Aggregates Dank Material Shell.
#
# #############################################################################

{

  nixosModules = [

    ./nixos/dms.nix

  ];

  hmModules = [

    ./home-manager/dms.nix

  ];

}
