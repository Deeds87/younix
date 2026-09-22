# file: software/tui/helix/home-manager/completions.nix

# #############################################################################
#
# Description:
# Configuration for snippets to use with simple-completion-language-server.
#
# #############################################################################

{ pkgs, lib, ... }:

{

  # Configuration file for simple-completion-language-server
  home.file.".config/helix/external-snippets.toml".text = ''
    [[sources]]
    name = "friendly-snippets"
    git = "https://github.com/rafamadriz/friendly-snippets.git"

    [[sources.paths]]
    scope = [ "markdown" ]
    path = "snippets/markdown.json"
  '';

  # Fetch and update external snippets for simpla-completion-language-server on rebuild
  home.activation.fetchSnippets = lib.hm.dag.entryAfter [ "installPackages" ] ''
    export PATH="${
      lib.makeBinPath [
        pkgs.git
        pkgs.simple-completion-language-server
      ]
    }:$PATH"
    ${pkgs.simple-completion-language-server}/bin/simple-completion-language-server fetch-external-snippets
  '';

}
