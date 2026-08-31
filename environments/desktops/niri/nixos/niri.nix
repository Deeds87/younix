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
    xwayland-satellite # X11-application compatibility
    xdg-terminal-exec # Used for application-independent keybinds
  ];

  # NIRI MODULE ===============================================================

  programs.niri = {
    enable = true;
    useNautilus = true;
  };

}
