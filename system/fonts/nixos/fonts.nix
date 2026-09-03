# file: system/fonts/nixos/fonts.nix

# #############################################################################
#
# Description:
# Collection of fonts to be present on the system.
#
# #############################################################################

{ pkgs, ... }:

{

  fonts.packages = with pkgs; [

    # ------------------------------------------ Nerd-fonts
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code

    # ------------------------------------------ General UI
    noto-fonts
    noto-fonts-color-emoji

    # --------------------------------------- Compatibility
    liberation_ttf

  ];

}
