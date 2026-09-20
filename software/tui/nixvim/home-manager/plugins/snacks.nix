# file: software/tui/nixvim/home-manager/plugins/snacks.nix

# #############################################################################
#
# Description:
# Different bundled QoL plugins.
#
# #############################################################################

{ ... }:

{

  programs.nixvim = {

    plugins.snacks = {

      enable = true;

      # CONFIGRATION ==========================================================

      settings = {

        # ---------------------------------------- Explorer
        explorer = {
          replace_netrw = true;
        };

        # ----------------------------------------- Lazygit
        lazygit = {
          configure = false;
        };

        # ---------------------------------------- Zen Mode
        # styles = {
        #   zen = {
        #     width = 0;
        #     minimal = false;
        #   };
        # };

      };
    };

    # KEYMAPS =================================================================

    keymaps = [

      # ---------------------------------------- Pick files
      {
        mode = "n";
        key = "<leader><space>";
        action.__raw = "function() Snacks.picker.files() end";
        options = {
          desc = "Find Files";
          silent = true;
        };
      }

      # ----------------------------------------- Live grep
      {
        mode = "n";
        key = "<leader>f/";
        action.__raw = "function() Snacks.picker.grep() end";
        options = {
          desc = "File Grep";
          silent = true;
        };
      }

      # --------------------------------------- Pick buffer
      {
        mode = "n";
        key = "<leader>bb";
        action.__raw = "function() Snacks.picker.buffers() end";
        options = {
          desc = "Buffer picker";
          silent = true;
        };
      }

      # ------------------------------------------ Explorer
      {
        mode = "n";
        key = "<leader>e";
        action.__raw = "function() Snacks.explorer() end";
        options = {
          desc = "File Explorer";
          silent = true;
        };
      }

      # ------------------------------------------- Lazygit
      {
        mode = "n";
        key = "<leader>gl";
        action.__raw = "function() Snacks.lazygit() end";
        options = {
          desc = "LazyGit";
          silent = true;
        };
      }

      # ------------------------------------- Delete buffer
      {
        mode = "n";
        key = "<leader>bd";
        action.__raw = "function() Snacks.bufdelete() end";
        options = {
          desc = "Delete Buffer";
          silent = true;
        };
      }

      # ------------------------------------------ Zen Mode
      {
        mode = "n";
        key = "<leader>z";
        action.__raw = "function() Snacks.toggle.dim():toggle() end";
        options = {
          desc = "Zen Mode";
          silent = true;
        };
      }

    ];
  };
}
