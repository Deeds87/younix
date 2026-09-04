# file: environments/desktops/kde/nixos/kde.nix

# #############################################################################
#
# Description:
# KDE plasma desktop.
#
# #############################################################################

{ ... }:

{
  # Enable KDE plasma 6 desktop manager
  services.desktopManager.plasma6.enable = true;
}
