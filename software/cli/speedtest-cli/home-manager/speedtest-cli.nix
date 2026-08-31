# file: software/cli/speedtest-cli/home-manager/speedtest-cli.nix

# #############################################################################
#
# Description:
# Speedtest-CLI - Internet speedtest
#
# #############################################################################

{ pkgs, ... }:

{

  home.packages = with pkgs; [

    speedtest-cli

  ];

}
