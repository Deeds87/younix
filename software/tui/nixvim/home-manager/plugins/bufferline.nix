# file: software/tui/nixvim/home-manager/plugins/bufferline.nix

# #############################################################################
#
# Description:
# Plugin to show buffers as tabs.
#
# #############################################################################

{ ... }:

{

  programs.nixvim = {

    plugins.bufferline = {

      enable = true;

    };

  };

}
