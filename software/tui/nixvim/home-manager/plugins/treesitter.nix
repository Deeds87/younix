# file: software/tui/nixvim/home-manager/plugins/treesitter.nix

# #############################################################################
#
# Description:
# Plugin to manage tree-sitter-parsers and queries.
#
# #############################################################################

{ ... }:

{

  programs.nixvim = {

    plugins.treesitter = {

      enable = true;

    };

  };

}
