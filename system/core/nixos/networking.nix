# file: system/core/nixos/networking.nix

# #############################################################################
#
# Description:
# The networking module configures the networking backend.
#
# #############################################################################

{ config, ... }:

let

  hostname = config.younix.system.hostname;

in

{

  # Set hostname
  networking.hostName = hostname;

  # Enable network-manager
  networking.networkmanager.enable = true;

  # Enable Avahi for local network service discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

}
