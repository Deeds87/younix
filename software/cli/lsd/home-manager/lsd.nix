# file: software/cli/lsd/home-manager/lsd.nix

# #############################################################################
#
# Description:
# LSD - Modern 'ls' replacement
#
# #############################################################################

{ ... }:

{

  programs.lsd = {

    enable = true;

    settings = {
      color = {
        when = "auto";
        theme = "custom";
      };
      display = "almost-all";
      sorting = {
        dir-grouping = "first";
      };
      indicators = true;
    };

    colors = {
      user = 24;
      group = 111;

      permission = {
        read = 153;
        write = 117;
        exec = 24;
        exec-sticky = 31;
        no-access = 60;
        octal = 111;
        acl = 111;
        context = 69;
      };

      date = {
        hour-old = 153;
        day-old = 111;
        older = 60;
      };

      size = {
        none = 60;
        small = 153;
        medium = 189;
        large = 117;
      };

      inode = {
        valid = 24;
        invalid = 60;
      };

      links = {
        valid = 111;
        invalid = 60;
      };

      tree-edge = 238;

      git-status = {
        default = 255;
        unmodified = 60;
        ignored = 238;
        new-in-index = 153;
        new-in-workdir = 111;
        typechange = 117;
        deleted = 31;
        renamed = 69;
        modified = 75;
        conflicted = 195;
      };
    };

  };

}
