# file: features/virtualization/virtualbox/default.nix

# #############################################################################
#
# Description:
# Aggregates the virtualbox component.
#
# #############################################################################

{ ... }:

{

  nixosModules = [

    ./nixos/virtualbox.nix

  ];

  hmModules = [ ];

}
