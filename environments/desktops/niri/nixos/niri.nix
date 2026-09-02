# file: environments/desktops/niri/nixos/niri.nix

# #############################################################################
#
# Description:
# Niri NixOS module
#
# #############################################################################

{ pkgs, ... }:

{

  # DEPENDENCIES ==============================================================

  environment.systemPackages = with pkgs; [

    # --------------------------------------------  Runtime
    xwayland-satellite # X11-application compatibility
    xdg-terminal-exec # Used for application-independent keybinds
    python3 # Used for addon scripts

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
    nautilus # File-Manager
  ];

  # NIRI MODULE ===============================================================

  programs.niri = {
    enable = true;
    useNautilus = true;
  };

}
