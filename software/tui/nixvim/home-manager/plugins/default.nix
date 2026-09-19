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

    ./which-key.nix # Popup for keymaps
    ./yazi.nix # Filemanager

  ];

}
