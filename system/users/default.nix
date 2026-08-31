# file: system/users/default.nix

# #############################################################################
#
# Description:
# Aggregates configured system users.
#
# #############################################################################

{ ... }:

{

  nixosModules = [

    ./nixos/init-user.nix

  ];

  hmModules = [ ];

}
