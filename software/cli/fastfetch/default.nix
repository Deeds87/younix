# file: software/cli/fastfetch/default.nix

# #############################################################################
#
# Descriptions:
# Aggregates fastfetch system information application.
#
# #############################################################################

{

  nixosModule = [ ];

  hmModules = [

    ./home-manager/fastfetch.nix

  ];

}
