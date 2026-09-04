# file: software/tui/yazi/home-manager/yazi.nix

# #############################################################################
#
# Description:
# Yazi - Terminal file manager
#
# #############################################################################

{ pkgs, ... }:

{

  programs.yazi = {

    enable = true;
    enableZshIntegration = true;
    shellWrapperName = "y";

    plugins = with pkgs; {
      gvfs = {
        package = yaziPlugins.gvfs;
        setup = true;
      };
    };

    keymap = {
      mgr.prepend_keymap = [
        {
          on = [
            "M"
            "m"
          ];
          run = "plugin gvfs -- select-then-mount --jump";
          desc = "Mount GVFS device/share";
        }
        {
          on = [
            "M"
            "u"
          ];
          run = "plugin gvfs -- select-then-unmount";
          desc = "Unmount GVFS device/share";
        }
        {
          on = [
            "M"
            "a"
          ];
          run = "plugin gvfs -- add-mount";
          desc = "Add GVFS mount";
        }
        {
          on = [
            "M"
            "e"
          ];
          run = "plugin gvfs -- edit-mount";
          desc = "Edit GVFS mount";
        }
        {
          on = [
            "M"
            "r"
          ];
          run = "plugin gvfs -- remove-mount";
          desc = "Remove GVFS mount";
        }
        {
          on = [
            "g"
            "m"
          ];
          run = "plugin gvfs -- jump-to-device";
          desc = "Jump to GVFS device";
        }
      ];
    };

  };

}
