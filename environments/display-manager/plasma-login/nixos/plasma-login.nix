# file: environments/display-manager/plasma-login/nixos/plasma-login.nix

# #############################################################################
#
# Description:
# Plasma login manager.
#
# #############################################################################

{ ... }:

{

  services.displayManager.plasma-login-manager.enable = true;

}
