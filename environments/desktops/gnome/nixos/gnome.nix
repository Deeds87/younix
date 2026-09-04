# file: environments/desktops/nixos/gnome.nix

# #############################################################################
#
# Description:
# GNOME desktop.
#
# #############################################################################

{
  pkgs,
  ...
}:

{
  # Enable gnome desktop manager
  services.desktopManager.gnome.enable = true;

  # Default gnome applications to exclude
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
    yelp
    epiphany
  ];
}
