# file: software/tui/nixvim/plugins/default.nix

# #############################################################################
#
# Description:
# Nixvim plugin aggregator.
#
# #############################################################################

{ ... }:

{

  imports = [

    ./treesitter.nix # Manage tree-sitter-parsers
    ./snacks.nix # Different QoL plugins
    ./which-key.nix # Popup for keymaps
    ./mini-icons.nix # Get icons
    ./noice.nix # Modern UI
    ./bufferline.nix # Show buffers as tabs
    ./lualine.nix # Show a nicer statusline
    # ./yazi.nix # Filemanager
    ./blink-pairs.nix # Autocomplete delimiter pairs
    ./todo-comments.nix # Make todo comments available

  ];

}
