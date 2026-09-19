# file: software/tui/nixvim/plugins/which-key.nix

# #############################################################################
#
# Description:
# Neovim plugin to show a popup for available keymaps.
#
# #############################################################################

{ ... }:

{

  programs.nixvim = {

    plugins.which-key = {

      enable = true;

      settings = {

        # CORE ==============================================================

        # Do not show which-key on following operations and modes
        defer = ''
          function(ctx)
            if vim.list_contains({ "c", "d", "y", "!" }, ctx.operator) then
              return true
            end
            if vim.list_contains({ "v", "V", "" }, ctx.mode) then
              return true
            end
            return false
          end
        '';

        # Respect nvim timeout
        timeout = true;

        # LOOK & FEEL =======================================================

        # --------------------------------------- UI preset
        preset = "helix";

        # ------------------------------------------ Window
        win = {
          border = "solid";
          padding = [
            2
            2
            2
            2
          ];
          title = true;
          title_pos = "center";
          no_overlap = true;
        };

        # ------------------------------------------- Icons
        icons = {
          breadcrumb = "»";
          separator = "➜";
          group = " + ";
        };

        # GROUPS ============================================================

        spec = [
          {
            __unkeyed-1 = "<leader>b";
            group = "Buffers";
            icon = " ";
          }
          {
            __unkeyed-1 = "<leader>g";
            group = "Git";
            icon = "󰊢 ";
          }
          {
            __unkeyed-1 = "<leader>f";
            group = "Find & Search";
            icon = "󰍉 ";
          }
          {
            __unkeyed-1 = "<leader>q";
            group = "Quit";
            icon = "󰅖 ";
          }
          {
            __unkeyed-1 = "<leader>w";
            group = "Write/Save";
            icon = "󰉉 ";
          }
          {
            __unkeyed-1 = "<leader>e";
            group = "Filemanager (CWD)";
            icon = " ";
          }
        ];

      };

    };

  };

}
