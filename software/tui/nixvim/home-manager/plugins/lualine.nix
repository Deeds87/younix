# file: software/tui/nixvim/home-manager/plugins/lualine.nix

# #############################################################################
#
# Description:
# Show a nicer statusline at the bottom.
#
# #############################################################################

{ ... }:

{

  programs.nixvim = {

    plugins.lualine = {

      enable = true;

    };

  };

}
