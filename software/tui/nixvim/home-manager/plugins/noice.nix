# file: software/tui/nixvim/home-manager/plugins/noice.nix

# #############################################################################
#
# Description:
# Plugin for a more modern UI.
#
# #############################################################################

{ ... }:

{

  programs.nixvim = {

    plugins.noice = {

      enable = true;

      settings = {
        lsp = {
          override = {
            "vim.lsp.util.convert_input_to_markdown_lines" = true;
            "vim.lsp.util.stylize_markdown" = true;
          };
        };

        presets = {
          bottom_search = true;
          command_palette = true;
          long_message_to_split = true;
          lsp_doc_border = true;
        };

      };

    };

  };

}
