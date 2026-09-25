# file: software/cli/git/home-manager/git.nix

# #############################################################################
#
# Description:
# Git Version Control
#
# #############################################################################

{ osConfig, ... }:

let

  user = osConfig.younix.user;

in

{

  programs.git = {

    enable = true;

    settings.user = {
      name = user.gitName;
      email = user.gitEmail;
    };

  };

}
