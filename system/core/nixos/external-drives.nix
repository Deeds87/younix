# file: system/core/nixos/external-drives.nix

# #############################################################################
#
# Description:
# The external-drives module configures external drive access.
#
# #############################################################################

{ ... }:

{

  # Enable external and removable storage management
  services.udisks2.enable = true;

  # Enable filesystem integration for GTK applications
  services.gvfs.enable = true;

}
