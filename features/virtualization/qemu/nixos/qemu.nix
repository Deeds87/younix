# file: features/virtualization/qemu/nixos/qemu.nix

# #############################################################################
#
# Description:
# This file configures qemu virtualization.
#
# #############################################################################

{
  config,
  pkgs,
  lib,
  ...
}:

let

  mode = config.younix.features.virtualization.mode;
  username = config.younix.user.username;

in

{
  config = lib.mkMerge [

    # QEMU HOST CONFIGURATION =================================================

    (lib.mkIf (mode == "host") {

      # Enable libvirtd
      virtualisation.libvirtd.enable = true;

      # Install virtiofs to use shared folders
      virtualisation.libvirtd.qemu.vhostUserPackages = with pkgs; [
        virtiofsd
      ];

      # Add user to libvirtd group
      users.users.${username}.extraGroups = [ "libvirtd" ];

    })

    # QEMU GUEST CONFIGURATION ================================================

    (lib.mkIf (mode == "guest") {

      # Enable qemu guest agent
      services.qemuGuest.enable = true;

      # Enable SPICE guest agent
      services.spice-vdagentd.enable = true;

    })
  ];

}
