# file: software/cli/fastfetch/default.nix

# #############################################################################
#
# Descriptions:
# Aggregates fastfetch system information application.
#
# #############################################################################

{

  nixosModules = [ ];

  hmModules = [

    ./home-manager/fastfetch.nix

  ];

}
