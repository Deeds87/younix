# file: software/cli/zoxide/default.nix

# #############################################################################
#
# Description:
# Aggegates zoxide, a modern cd alternative.
#
# #############################################################################

{

  nixosModules = [ ];

  hmModules = [

    ./home-manager/zoxide.nix

  ];

}
