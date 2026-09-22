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
# TODO: Datei aufteilen (keymaps, options, lsp, usw.)
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
      simple-completion-language-server
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
            language-servers = [
              "markdown-oxide"
              "simple-completion-language-server"
            ];
          }
        ];

        # Language servers ----------------------------------
        language-server = {
          markdown-oxide = {
            command = "markdown-oxide";
          };

          simple-completion-language-server = {
            command = "simple-completion-language-server";
            config = {
              feature_words = false;
              feature_snippets = true;
              snippets_first = true;
            };
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

    home.file.".config/helix/external-snippets.toml".text = ''
      [[sources]]
      name = "friendly-snippets"
      git = "https://github.com/rafamadriz/friendly-snippets.git"

      [[sources.paths]]
      scope = [ "markdown" ]
      path = "snippets/markdown.json"
    '';

    home.activation.fetchSnippets = lib.hm.dag.entryAfter [ "installPackages" ] ''
      export PATH="${
        lib.makeBinPath [
          pkgs.git
          pkgs.simple-completion-language-server
        ]
      }:$PATH"
      ${pkgs.simple-completion-language-server}/bin/simple-completion-language-server fetch-external-snippets
    '';
  };
}
