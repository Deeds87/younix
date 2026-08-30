# file: system/core/nixos/power.nix

# #############################################################################
#
# Description:
# The power module configures powermanagement.
#
# #############################################################################

{ ... }:

{

  # Enable power-profiles deamon
  services.power-profiles-daemon.enable = true;

  # Enable uPower
  services.upower.enable = true;

}
