# file: software/tui/lazygit/default.nix

# #############################################################################
#
# Description:
# Aggregates lazygit, a git tui frontend.
#
# #############################################################################

{

  nixosModules = [ ];

  hmModules = [

    ./home-manager/lazygit.nix

  ];

}
