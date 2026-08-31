# file: features/virtualization/virtualbox/nixos/virtualbox.nix

# #############################################################################
#
# Description:
# This file configures virtualbox virtualization.
#
# #############################################################################

{ config, lib, ... }:

let

  mode = config.younix.features.virtualization.mode;
  username = config.younix.user.username;

in

{
  config = lib.mkMerge [

    # VIRTUALBOX HOST CONFIGURATION ===========================================

    (lib.mkIf (mode == "host") {

      # Enable virtualbox
      virtualisation.virtualbox.host.enable = true;

      # Add user to vboxusers group
      users.extraGroups.vboxusers.members = [ username ];

      # DO NOT ENABLE THIS UNLESS YOU REALLY NEED IT!
      # It recompiles the VirtualBox package on every rebuild,
      # which can take a very long time.

      # virtualisation.virtualbox.host.enableExtensionPack = true;

    })

    # VIRTUALBOX GUEST CONFIGURATION ==========================================

    (lib.mkIf (mode == "guest") {

      # Enable virtualbox guest additions
      virtualisation.virtualbox.guest.enable = true;

      # Enable drag and drop
      virtualisation.virtualbox.guest.dragAndDrop = true;

      # Add user to vboxsf group
      users.users.${username}.extraGroups = [ "vboxsf" ];

    })
  ];

}
