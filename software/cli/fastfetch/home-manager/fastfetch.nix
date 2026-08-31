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
      logo = {
        source = "nixOS2";
      };

      modules = [

        {
          type = "title";
          key = "╭─ ";
          format = "{user-name}@{host-name}";
          keyColor = "#b892ff";
        }
        {
          type = "disk";
          key = "├─󰸗 ";
          keyColor = "#b892ff";
          folders = "/";
          format = "{create-time:10} ({days} days)";
        }
        {
          type = "packages";
          key = "├─󰏖 ";
          keyColor = "#b892ff";
        }
        {
          type = "kernel";
          key = "╰─ ";
          keyColor = "#b892ff";
        }
        "break"
        "break"
        {
          type = "disk";
          key = "╭─ ";
          keyColor = "#9a7cff";
        }
        {
          type = "memory";
          key = "├─󰑭 ";
          keyColor = "#9a7cff";
        }
        {
          type = "swap";
          key = "╰─󰓡 ";
          keyColor = "#9a7cff";
        }
        "break"
        {
          type = "colors";
          paddingLeft = 10;
          symbol = "circle";
        }

      ];

    };

  };

}
