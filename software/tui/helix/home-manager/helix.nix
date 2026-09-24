# file: software/tui/helix/home-manager/helix.nix

# #############################################################################
#
# Description:
# Helix - Vim like modal editor.
#
# #############################################################################

{ pkgs, inputs, ... }:

{
  programs.helix = {

    # GENERAL SETUP ===========================================================
    enable = true;

    # Use package from master branch
    package = inputs.helix.packages."${pkgs.stdenv.hostPlatform.system}".helix;

    # -------------------------------------- Extra packages
    extraPackages = with pkgs; [
      nixd # LSP for Nix
      nixfmt # Formatter for Nix
      markdown-oxide # LSP for Markdown
      simple-completion-language-server # LSP for completions
      hx-lsp # LSP for snippets, code-actions and document-colors
    ];

    # EDITOR CONFIGURATION ====================================================

    settings = {

      # --------------------------------------------- Theme
      theme = {
        light = "ayu_light";
        dark = "ayu_dark";
      };

      editor = {

        # ----------------------------------------- General
        scrolloff = 10;
        line-number = "relative";
        color-modes = true;

        # ------------------------------------------ Cursor
        cursorline = true;
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };

        # ----------------------------------------- Gutters
        gutters = [
          "diagnostics"
          "spacer"
          "code-action-hint"
          "spacer"
          "line-numbers"
          "spacer"
          "diff"
        ];

        # ------------------------------------- File-Picker
        file-picker = {
          git-ignore = false;
        };

        # -------------------------------------- Whitespace
        whitespace = {
          render = {
            space = "all";
            tab = "all";
            nbsp = "none";
            nnbsp = "none";
            newline = "none";
          };
        };

        # ------------------------------------- Indentation
        indent-guides = {
          render = true;
        };

        # -------------------------------------- Bufferline
        bufferline = "multiple";

        # -------------------------------------- Statusline
        statusline = {
          left = [
            "mode"
            "spacer"
            "version-control"
            "spacer"
            "spinner"
          ];
          center = [
            "current-working-directory"
            "spacer"
            "separator"
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

        # ------------------------ Diagnostics and messages
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

    };

  };
}
