# file: software/tui/yazi/home-manager/yazi.nix

# #############################################################################
#
# Description:
# Yazi - Terminal file manager
#
# #############################################################################

{ ... }:

{

  programs.yazi = {

    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";

  };

}
