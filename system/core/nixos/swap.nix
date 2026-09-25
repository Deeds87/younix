# file: system/core/nixos/swap.nix

# #############################################################################
#
# Description:
# Manages system swap.
#
# #############################################################################

{ ... }:

{

  # Enable zram for faster swap on high memory pressure
  zramSwap.enable = true;

  # Enable swapspace to handle disk swap dynamically
  services.swapspace.enable = true;

  # Enable systemd-oomd to kill processes before the system crashes
  # on extremely high memory pressure
  systemd.oomd.enable = true;

}
