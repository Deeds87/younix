# file: system/core/nixos/ssh.nix

# =============================================================================
#
# Description:
# Module to manage SSH service.
#
# =============================================================================

{ ... }:

{

  # Setup OpenSSH server
  services.openssh = {

    enable = true;

    settings = {
      PermitRootLogin = "no";
    };

  };

  # Allow SSH connections through the firewall
  networking.firewall.allowedTCPPorts = [ 22 ];

}
