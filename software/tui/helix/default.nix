# file: software/tui/helix/default.nix

# #############################################################################
#
# Description:
# Aggregates helix modal editor.
#
# #############################################################################

{

  nixosModules = [ ];

  hmModules = [

    ./home-manager/helix.nix
    ./home-manager/keymaps.nix

  ];

}
