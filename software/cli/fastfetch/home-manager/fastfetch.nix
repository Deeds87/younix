# file: software/cli/fastfetch/home-manager/fastfetch.nix

# #############################################################################
#
# Description:
# Fastfetch - System Information
#
# #############################################################################

{ ... }:

{

  programs.fastfetch = {

    enable = true;

    settings = {
      logo = null;
      # source = "nixOS2";
      # };

      modules = [

        # ------------------------ Basic system information
        {
          type = "title";
          key = "╭─ ";
          format = "{user-name}@{host-name}";
        }
        {
          type = "disk";
          key = "├─󰸗 ";
          folders = "/";
          format = "{create-time:10} ({days} days)";
        }
        {
          type = "packages";
          key = "├─󰏖 ";
        }
        {
          type = "kernel";
          key = "╰─ ";
        }
        "break"
        "break"

        # ----------------------------------------- Network
        {
          type = "wifi";
          key = "╭─ ";
        }
        {
          type = "localip";
          key = "├─󰩟 ";
        }
        {
          type = "dns";
          key = "╰─󰇖 ";
        }
        "break"
        "break"

        # --------------------------------------- Resources
        {
          type = "disk";
          key = "╭─ ";
        }
        {
          type = "memory";
          key = "╰─󰑭 ";
        }
        "break"

        # ------------------------------------------ Colors
        {
          type = "colors";
          paddingLeft = 10;
          symbol = "circle";
        }

      ];

    };

  };

}
