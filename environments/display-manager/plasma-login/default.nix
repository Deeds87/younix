# file: environments/display-manager/plasma-login/default.nix

# #############################################################################
#
# Description:
# Aggregates Plasma login manager.
#
# #############################################################################

{

  nixosModules = [

    ./nixos/plasma-login.nix

  ];

  hmModules = [ ];

}
