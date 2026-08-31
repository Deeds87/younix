# file: features/virtualization/qemu/default.nix

# #############################################################################
#
# Description:
# Aggregates the qemu component.
#
# #############################################################################

{ ... }:

{

  nixosModules = [

    ./nixos/qemu.nix

  ];

  hmModules = [ ];

}
