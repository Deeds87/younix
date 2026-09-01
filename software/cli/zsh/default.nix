# file: software/cli/zsh/default.nix

# #############################################################################
#
# Description:
# Aggregates ZSH.
#
# #############################################################################

{

  nixosModules = [ ];

  hmModules = [

    ./home-manager/zsh.nix

  ];

}
