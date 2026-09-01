# file: software/gui/obsidian/default.nix

# #############################################################################
#
# Description:
# Aggregates obsidian notetaking app.
#
# #############################################################################

{

  nixosModules = [ ];

  hmModules = [

    ./home-manager/obsidian.nix

  ];

}
