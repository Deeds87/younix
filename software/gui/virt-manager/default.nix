# file: software/gui/virt-manager/default.nix

# #############################################################################
#
# Description:
# Aggregates virt-manager, qemu/kvm frontend.
#
# #############################################################################

{

  nixosModules = [ ];

  hmModules = [

    ./home-manager/virt-manager.nix

  ];

}
