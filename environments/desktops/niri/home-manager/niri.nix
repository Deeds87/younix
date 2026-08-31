# file: environments/desktops/niri/home-manager/niri.nix

# #############################################################################
#
# Description:
# Niri Home-Manager module.
#
# #############################################################################

{ osConfig, pkgs, ... }:

let

  username = osConfig.younix.user.username;

in

{
  # DEPENDENCIES ==============================================================

  home-manager.users.${username}.home.packages = with pkgs; [

    # --------------------------------------------- Theming
    adw-gtk3
    adwaita-icon-theme
    bibata-cursors

    # ---------------------------------- Desktop essentials
    kitty # Terminal emulator
    papers # Document viewer
    loupe # Image viewer
    showtime # Video player
    decibels # Audio player

  ];

}
