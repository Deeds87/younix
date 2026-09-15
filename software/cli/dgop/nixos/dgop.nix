# file: software/cli/dgop/nixos/dgop.nix

# #############################################################################
#
# Description:
# Dgop - System monitoring tool.
#
# #############################################################################

{ inputs, pkgs, ... }:

{
  environment.systemPackages = [
    inputs.dgop.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
