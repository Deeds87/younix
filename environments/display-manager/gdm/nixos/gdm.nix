# file: environments/display-manager/gdm/nixos/gdm.nix

# #############################################################################
#
# Description:
# GDM display-manager.
#
# #############################################################################

{ ... }:

{

  services.displayManager.gdm.enable = true;

}
