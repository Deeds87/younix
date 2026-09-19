# file: software/tui/nixvim/home-manager/plugin/todo-comments.nix

# #############################################################################
#
# Description:
# Plugin for todo comments.
#
# #############################################################################

{ ... }:

{

  programs.nixvim = {

    plugins.todo-comments = {

      enable = true;

    };

  };

}
