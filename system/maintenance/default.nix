# file: system/maintenance/default.nix

# #############################################################################
#
# Description:
# Aggregates NixOS and Home-Manager modules for maintenance
# system configuration.
#
# #############################################################################

{ ... }:

{

  nixosModules = [

    ./nixos/general.nix
    ./nixos/cleanup.nix
    ./nixos/updates.nix

  ];

  hmModules = [ ];

}
