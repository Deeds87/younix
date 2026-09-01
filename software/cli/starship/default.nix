# file: software/cli/starship/default.nix

# #############################################################################
#
# Description:
# Aggregates starship terminal prompt.
#
# #############################################################################

{

  nixosModules = [ ];

  hmModules = [

    ./home-manager/starship.nix

  ];

}
