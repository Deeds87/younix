# file: software/tui/helix/home-manager/lsp.nix

# #############################################################################
#
# Description:
# All language and language-server settings for Helix editor.
#
# #############################################################################

{
  pkgs,
  lib,
  osConfig,
  ...
}:

let

  hostname = osConfig.networking.hostName;

in

{

  programs.helix = {

    # LANGUAGES =============================================================

    languages = {

      language = [

        # ------------------------------------------- Nix
        {
          name = "nix";
          auto-format = true;
          language-servers = [ "nixd" ];
          formatter = {
            command = "${lib.getExe pkgs.nixfmt}";
            args = [ "-" ];
          };
        }

        # -------------------------------------- Markdown
        {
          name = "markdown";
          language-servers = [
            "markdown-oxide"
            "simple-completion-language-server"
          ];
        }
      ];

      # LANGUAGE SERVERS ====================================================

      language-server = {

        # -------------------------------------- Markdown
        markdown-oxide = {
          command = "markdown-oxide";
        };

        # ----------------------------------- Completions
        simple-completion-language-server = {
          command = "simple-completion-language-server";
          config = {
            feature_words = false;
            feature_snippets = true;
            snippets_first = true;
          };
        };

        # ------------------------------------------- Nix
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
