# file: software/tui/nixvim/home-manager/plugins/yazi.nix

# #############################################################################
#
# Description:
# Yazi filemanager.
#
# #############################################################################

{ ... }:

{

  programs.nixvim = {

    # Mark netrw as loaded to disable it
    globals.loaded_netrwPlugin = 1;

    keymaps = [
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>e";
        action = ":Yazi<CR>";
      }
    ];

    plugins.yazi = {

      enable = true;

      settings = {

        # Use yazi to open directories
        open_for_directories = true;

      };

    };

  };

}
