# file: software/cli/starship/home-manager/starship.nix

# #############################################################################
#
# Description:
# Starship Prompt
#
# #############################################################################

{ ... }:

let

  colorpalette = "blue";

in

{

  programs.starship = {

    enable = true;
    enableZshIntegration = true;

    settings = {

      "$schema" = "https://starship.rs/config-schema.json";

      format = builtins.concatStringsSep "" [
        "[](color_05)"
        "$os"
        "$username"
        "[](bg:color_07 fg:color_05)"
        "$directory"
        "[](bg:color_08 fg:color_07)"
        "$git_branch"
        "$git_status"
        "[](fg:color_08 bg:color_14)"
        "$c"
        "$rust"
        "$golang"
        "$nodejs"
        "$php"
        "$java"
        "$kotlin"
        "$haskell"
        "$python"
        "$conda"
        "[ ](fg:color_14)"
        "$cmd_duration"
        "$line_break"
        "$character"
      ];

      palette = colorpalette;

      os = {
        disabled = false;
        style = "bg:color_05 fg:color_26";
        symbols = {
          NixOS = "";
        };
      };

      username = {
        show_always = true;
        style_user = "bg:color_05 fg:color_26";
        style_root = "bg:color_05 fg:color_26";
        format = "[ $user]($style)";
      };

      directory = {
        style = "bg:color_07 fg:color_26";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
        substitutions = {
          Documents = "󰈙 ";
          Downloads = " ";
          Music = "󰝚 ";
          Pictures = " ";
          Developer = "󰲋 ";
        };
      };

      # Git -----------------------------------------------
      git_branch = {
        symbol = "";
        style = "bg:color_08";
        format = "[[ $symbol $branch ](fg:color_26 bg:color_08)]($style)";
      };

      git_status = {
        style = "bg:color_08";
        format = "[[($all_status$ahead_behind )](fg:color_26 bg:color_08)]($style)";
      };

      # Languages -----------------------------------------
      c = {
        symbol = " ";
        style = "bg:color_09";
        format = "[[ $symbol( $version) ](fg:color_26 bg:color_09)]($style)";
      };

      rust = {
        symbol = "";
        style = "bg:color_09";
        format = "[[ $symbol( $version) ](fg:color_26 bg:color_09)]($style)";
      };

      golang = {
        symbol = "";
        style = "bg:color_09";
        format = "[[ $symbol( $version) ](fg:color_26 bg:color_09)]($style)";
      };

      nodejs = {
        symbol = "";
        style = "bg:color_09";
        format = "[[ $symbol( $version) ](fg:color_26 bg:color_09)]($style)";
      };

      php = {
        symbol = "";
        style = "bg:color_09";
        format = "[[ $symbol( $version) ](fg:color_26 bg:color_09)]($style)";
      };

      java = {
        symbol = " ";
        style = "bg:color_09";
        format = "[[ $symbol( $version) ](fg:color_26 bg:color_09)]($style)";
      };

      kotlin = {
        symbol = "";
        style = "bg:color_09";
        format = "[[ $symbol( $version) ](fg:color_26 bg:color_09)]($style)";
      };

      haskell = {
        symbol = "";
        style = "bg:color_09";
        format = "[[ $symbol( $version) ](fg:color_26 bg:color_09)]($style)";
      };

      python = {
        symbol = "";
        style = "bg:color_09";
        format = "[[ $symbol( $version) ](fg:color_26 bg:color_09)]($style)";
      };

      conda = {
        symbol = "  ";
        style = "bg:color_09";
        format = "[[ $symbol( $version) ](fg:color_26 bg:color_09)]($style)";
      };

      cmd_duration = {
        show_milliseconds = true;
        format = " in $duration ";
        style = "bg:color_14";
        disabled = false;
        show_notifications = false;
        min_time_to_notify = 45000;
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:color_14";
        format = "[[  $time ](fg:color_26 bg:color_14)]($style)";
      };

      line_break = {
        disabled = false;
      };

      character = {
        disabled = false;
        success_symbol = "[❯](bold fg:color_09)";
        error_symbol = "[❯](bold fg:color_05)";
        vimcmd_symbol = "[❮](bold fg:color_09)";
        vimcmd_replace_one_symbol = "[❮](bold fg:color_14)";
        vimcmd_replace_symbol = "[❮](bold fg:color_14)";
        vimcmd_visual_symbol = "[❮](bold fg:color_08)";
      };

      palettes = {

        purple = {
          # color_01 = "#f6e1f2"; # rosewater
          # color_02 = "#eecdf0"; # flamingo
          # color_03 = "#e6bdf2"; # pink
          # color_04 = "#c8a2f8"; # mauve
          color_05 = "#d28aff"; # red
          # color_06 = "#b47bd6"; # maroon
          color_07 = "#b892ff"; # peach
          color_08 = "#c7a6ff"; # yellow
          color_09 = "#a98cff"; # green
          # color_10 = "#9a7cff"; # teal
          # color_11 = "#8b6cff"; # sky
          # color_12 = "#7c5cff"; # sapphire
          # color_13 = "#6d4cff"; # blue
          color_14 = "#d6c2ff"; # lavender
          # color_15 = "#e6ddff"; # text
          # color_16 = "#cfc4f2"; # subtext1
          # color_17 = "#b8addb"; # subtext0
          # color_18 = "#9f94c7"; # overlay2
          # color_19 = "#867bb0"; # overlay1
          # color_20 = "#6d6498"; # overlay0
          # color_21 = "#5a5180"; # surface2
          # color_22 = "#463c68"; # surface1
          # color_23 = "#322a50"; # surface0
          # color_24 = "#1b1628"; # base
          # color_25 = "#161122"; # mantle
          color_26 = "#100c1b"; # crust
        };

        green = {
          color_05 = "#8fd3a8";
          color_07 = "#a8e6cf";
          color_08 = "#b5e8c4";
          color_09 = "#9fe2b5";
          color_14 = "#d4f0c0";
          color_26 = "#102018";
        };

        blue = {
          color_05 = "#8fb8e8";
          color_07 = "#a8d8f0";
          color_08 = "#b5dff5";
          color_09 = "#9fc9f2";
          color_14 = "#d4e8f8";
          color_26 = "#101820";
        };

        orange = {
          color_05 = "#f2b880";
          color_07 = "#f6c99b";
          color_08 = "#f8d3a8";
          color_09 = "#f4c08f";
          color_14 = "#f9e0c0";
          color_26 = "#20150d";
        };

      };

    };
  };

}
