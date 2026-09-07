# file: system/core/nixos/security.nix

# #############################################################################
#
# Description:
# The security module configures the system security baseline.
#
# #############################################################################

{ ... }:

{

  # FIREWALL ==================================================================

  # Enable the system firewall
  # Ports will be handled by services itself
  networking.firewall.enable = true;

  # POLKIT ====================================================================

  # Enable Polkit for privileged desktop operations
  security.polkit = {
    enable = true;
    enablePkexecWrapper = true;
  };

  # SUDO ======================================================================

  # Require a password for sudo access by wheel users
  security.sudo.wheelNeedsPassword = true;
}
