# file: software/cli/speedtest-cli/default.nix

# #############################################################################
#
# Description:
# Aggregates speedtest-cli commandline internet speedtest.
#
# #############################################################################

{

  nixosModules = [ ];

  hmModules = [

    ./home-manager/speedtest-cli.nix

  ];

}
