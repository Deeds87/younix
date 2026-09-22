# file: software/tui/helix/home-manager/keymaps.nix

# #############################################################################
#
# Description:
# All custom keymaps for Helix editor.
#
# #############################################################################

{ ... }:

{

  programs.helix = {

    settings = {

      keys = {

        # NORMAL MODE =========================================================

        normal = {

          # --------------------------------------- General
          esc = [
            "collapse_selection"
            "keep_primary_selection"
          ];

          # --------------------------------------- Buffers

          "S-tab" = ":bp"; # Previous buffer
          "tab" = ":bn"; # Next buffer

          # SPACE MODE ========================================================

          space = {

            space = "file_picker";

            # ------------------------------ External tools
            # Open Yazi filemanager
            e = [
              ":sh rm -f /tmp/unique-ca1ea106"
              ":insert-output yazi '%{buffer_name}' --chooser-file=/tmp/unique-ca1ea106"
              ":sh printf '\\x1b[?1049h\\x1b[?2004h' > /dev/tty"
              ":open %sh{cat /tmp/unique-ca1ea106}"
              ":redraw"
              ":set mouse false"
              ":set mouse true"
            ];

            # Open Lazygit
            l = [
              ":write-all"
              ":noop %sh{kitty @ launch --type=overlay --wait-for-child-to-exit --cwd=current lazygit}"
              ":redraw"
              ":reload-all"
            ];

          };

        };

        # INSERT MODE =========================================================

        insert = { };

        # SELECT MODE =========================================================

        select = { };

      };

    };

  };

}
