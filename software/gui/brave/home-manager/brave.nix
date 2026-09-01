# file: software/gui/brave/home-manager/brave.nix

# #############################################################################
#
# Description:
# Brave Browser - Chromium based internet browser.
#
# #############################################################################

{ pkgs, ... }:

{

  home.packages = with pkgs; [
    brave
  ];

}
