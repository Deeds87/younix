# file: software/gui/libreoffice/home-manager/libreoffice.nix

# #############################################################################
#
# Description:
# Libre Office - Office suite
#
# #############################################################################

{ pkgs, ... }:

{

  home.packages = with pkgs; [

    libreoffice

  ];

}
