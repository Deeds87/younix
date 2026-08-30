# file: system/core/default.nix

# #############################################################################
#
# Description:
# Aggregates NixOS and Home-Manager modules for core system configuration.
# For exampla services, boot configuration and system security.
#
# #############################################################################

{ ... }:
{

  nixosModules = [
    ./nixos/audio.nix
    ./nixos/bluetooth.nix
    ./nixos/boot.nix
    ./nixos/external-drives.nix
    ./nixos/locale.nix
    ./nixos/networking.nix
    ./nixos/power.nix
    ./nixos/printing.nix
    ./nixos/security.nix
    ./nixos/ssh.nix
  ];

  hmModules = [ ];

}
