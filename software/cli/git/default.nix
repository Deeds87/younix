# file: software/cli/git/default.nix

# #############################################################################
#
# Description:
# Aggregates git version control.
#
# #############################################################################

{

  nixosModules = [ ];

  hmModules = [

    ./home-manager/git.nix

  ];

}
