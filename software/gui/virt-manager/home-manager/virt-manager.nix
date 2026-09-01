# file: software/gui/virt-manager/home-manager/virt-manager.nix

# #############################################################################
#
# Description:
# Virt-Manager - A QEMU/KVM frontend.
#
# #############################################################################

{ pkgs, ... }:

{

  home.packages = with pkgs; [

    virt-manager

  ];

}
