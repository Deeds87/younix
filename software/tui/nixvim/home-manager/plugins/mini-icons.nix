# file: software/tui/nixvim/home-manager/plugins/mini-icons.nix

# #############################################################################
#
# Description:
# Plugin to make icons available.
#
# #############################################################################

{ ... }:

{

  programs.nixvim = {

    plugins.mini-icons = {

      enable = true;

    };

  };

}
