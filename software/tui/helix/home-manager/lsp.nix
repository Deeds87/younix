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
            feature_words = false; # enable completion by word
            feature_snippets = true; # enable snippets
            snippets_first = true; # completions will return before snippets by default
            case_sensitive = false; # when true, only exact-case matches are suggested; when false, exact-case matches are just prioritized first
            snippets_inline_by_word_tail = false; # suggest snippets by WORD tail, for example text `xsq|` become `x^2|` when snippet `sq` has body `^2`
            feature_unicode_input = false; # enable "unicode input"
            feature_paths = false; # enable path completion
            feature_citations = false; # enable citation completion (only on `citation` feature enabled)
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
