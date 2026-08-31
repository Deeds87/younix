# file: environments/display-manager/dms-greeter/default.nix

# #############################################################################
#
# Description:
# Aggregates DMS-greeter.
#
# #############################################################################

{

  nixosModules = [

    ./nixos/dms-greeter.nix

  ];

  hmModules = [ ];

}
