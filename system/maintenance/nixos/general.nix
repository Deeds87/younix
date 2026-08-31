# file: system/maintenance/nixos/general.nix

# #############################################################################
#
# Description:
# General maintenance features and prequisists.
#
# #############################################################################

{ ... }:

{

  # NIX FEATURES ==============================================================

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # UNFREE SOFTWARE ===========================================================

  nixpkgs.config.allowUnfree = true;

  # PACKAGE OVERLAYS ==========================================================
  # This can be general overlays or fixes

  nixpkgs.overlays = [
    (import ./../../../younix/overlays)
  ];

}
