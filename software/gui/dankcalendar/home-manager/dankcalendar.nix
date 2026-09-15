# file: software/gui/dankcalendar/home-manager/dankcalendar.nix

# #############################################################################
#
# Description:
# Dank Calendar - Calendar application.
#
# #############################################################################

{ inputs, ... }:

{

  # Home-Manager module from flake input
  imports = [ inputs.dcal.homeModules.dank-calendar ];

  programs.dank-calendar = {
    enable = true;
  };

}
