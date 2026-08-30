# file: system/core/nixos/security.nix

# #############################################################################
#
# Description:
# The security module configures the system security baseline.
#
# #############################################################################

{ ... }:

{

  # Enable the system firewall
  # Ports will be handled by services itself
  networking.firewall.enable = true;

  # Enable Polkit for privileged desktop operations
  security.polkit.enable = true;

  # Require a password for sudo access by wheel users
  security.sudo.wheelNeedsPassword = true;
}
