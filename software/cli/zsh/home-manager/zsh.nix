# file: software/cli/zsh/home-manager/zsh.nix

# #############################################################################
#
# Description:
# ZSH - Modern interactive Shell
#
# #############################################################################

{ pkgs, ... }:

let

  editor = "hx";

in

{

  home.packages = with pkgs; [
    zsh-history-substring-search
  ];

  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";

    };

    initContent = ''
      bindkey -e

      HISTFILE=~/.zsh_history
      HISTSIZE=1000
      SAVEHIST=1000

      export EDITOR=${editor}
      export VISUAL=${editor}
      export SUDO_EDITOR=#${editor}

      source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh

      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down

      bindkey '^[OA' history-substring-search-up
      bindkey '^[OB' history-substring-search-down
    '';
  };

}
