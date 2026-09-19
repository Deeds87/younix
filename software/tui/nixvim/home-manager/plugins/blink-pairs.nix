# file: software/tui/nixvim/home-manager/plugins/blink-pairs.nix

# #############################################################################
#
# Description:
# Plugin to autocomplete delimiter pairs.
#
# #############################################################################

{ ... }:

{

  programs.nixvim = {

    plugins.blink-pairs = {

      enable = true;

    };

  };

}
