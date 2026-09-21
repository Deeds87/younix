# file: software/tui/helix/home-manager/helix.nix

# #############################################################################
#
# Description:
# Helix - Vim like modal editor.
#
# Dependencies:
# Yazi    - Filemanager
# Lazygit - Git frontend
# Kitty   - Terminal emulator
#
# These programs has to be installed when using the given keymaps.
#
# #############################################################################

{
  pkgs,
  lib,
  osConfig,
  inputs,
  ...
}:

let

  hostname = osConfig.networking.hostName;

in

{
  programs.helix = {

    enable = true;

    # Use package from master branch
    package = inputs.helix.packages."${pkgs.stdenv.hostPlatform.system}".helix;

    extraPackages = with pkgs; [
      nixd # LSP for Nix
      nixfmt # Formatter for Nix
      markdown-oxide # LSP for Markdown
    ];

    settings = {

      # THEME =================================================================

      theme = {
        light = "ayu_light";
        dark = "ayu_dark";
      };

      # GENERRAL SETTINGS =====================================================

      editor = {
        scrolloff = 10;
        line-number = "relative";
        color-modes = true;
        undercurl = true;
        cursorline = true;
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        gutters = [
          "diagnostics"
          "spacer"
          "code-action-hint"
          "spacer"
          "line-numbers"
          "spacer"
          "diff"
        ];

        file-picker = {
          git-ignore = false;
        };

        whitespace = {
          render = {
            space = "all";
            tab = "all";
            nbsp = "none";
            nnbsp = "none";
            newline = "none";
          };
        };

        indent-guides = {
          render = true;
        };

        bufferline = "always";

        statusline = {
          left = [
            "mode"
            "spacer"
            "version-control"
            "spacer"
            "spinner"
          ];
          center = [
            "file-name"
            "read-only-indicator"
            "file-modification-indicator"
          ];
          right = [
            "diagnostics"
            "selections"
            "register"
            "position"
            "file-encoding"
          ];
        };

        end-of-line-diagnostics = "hint";

        inline-diagnostics = {
          cursor-line = "error";
          other-lines = "disable";
        };

        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
      };

      # KEYBINDINGS ===========================================================

      keys = {

        # Normal mode -------------------------------------
        normal = {
          esc = [
            "collapse_selection"
            "keep_primary_selection"
          ];
          "S-tab" = ":bp"; # Previous buffer
          "tab" = ":bn"; # Next buffer

          # Space mode (leader)----------------------------
          space = {
            space = "file_picker";

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

        # Insert mode -------------------------------------
        insert = { };

        # Select mode -------------------------------------
        select = { };
      };
    };

    # LANGUAGE SERVERS ========================================================

    languages = {

      # Languages -----------------------------------------
      language = [
        {
          name = "nix";
          auto-format = true;
          language-servers = [ "nixd" ];
          formatter = {
            command = "${lib.getExe pkgs.nixfmt}";
            args = [ "-" ];
          };
        }
        {
          name = "markdown";
          language-servers = [ "markdown-oxide" ];
        }
      ];

      # Language servers ----------------------------------
      language-server = {
        markdown-oxide = {
          command = "markdown-oxide";
        };

        nixd = {
          command = "nixd";
          args = [ "--semantic-tokens=true" ];

          config = {
            nixpkgs.expr = "import (builtins.getFlake (builtins.toString ./.)).inputs.nixpkgs { }";
            formatting.command = [ "${lib.getExe pkgs.nixfmt}" ];

            options = {
              nixos.expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.${hostname}.options";

              home-manager.expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.${hostname}.options.home-manager.users.type.getSubOptions []";
            };
          };
        };
      };
    };
  };
}
