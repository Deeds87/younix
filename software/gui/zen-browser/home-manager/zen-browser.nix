# file: software/gui/zen-browser/home-manager/zen-browser.nix

# #############################################################################
#
# Description:
# Zen Browser
#
# #############################################################################

{
  inputs,
  pkgs,
  lib,
  osConfig,
  ...
}:

let

  locale = lib.replaceStrings [ "_" ".UTF-8" ] [ "-" "" ] osConfig.i18n.defaultLocale;

  # Extension Helper
  extension = shortId: guid: {
    name = guid;
    value = {
      install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
      installation_mode = "normal_installed";
    };
  };

  lockedPrefs = {
    # Prferences locked through autoconfig
    # Check these out at about:config
    "extensions.autoDisableScopes" = 0;
    "extensions.pocket.enabled" = false;
  };

  defaultPrefs = {
    # DefaultPrefs can be overwritten in GUI settings
    # Locale ----------------------------------------------
    "intl.locale.requested" = "${lib.toLower (lib.head (lib.splitString "-" locale))},en-US,${locale}";
    # Disabled by default because no locale-specific dictionary is
    # installed automatically.
    "layout.spellcheckDefault" = 0;

    # Layout ----------------------------------------------
    "zen.tabs.vertical.right-side" = true;
    "sidebar.visibility" = "hide-sidebar";
    "zen.ui.migration.compact-mode-button-added" = true;
    "zen.view.compact.enable-at-startup" = true;
    "zen.view.compact.toolbar-flash-popup" = true;

    # Style -----------------------------------------------
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

  };

  # EXTENSIONS ================================================================

  extensions = [
    # To add additional extensions, find it on addons.mozilla.org, find
    # the short ID in the url (like https://addons.mozilla.org/en-US/firefox/addon/!SHORT_ID!/)
    # Then go to https://addons.mozilla.org/api/v5/addons/addon/!SHORT_ID!/ to get the guid
    (extension "ublock-origin" "uBlock0@raymondhill.net")
    (extension "vimium-ff" "{d7742d87-e61d-4b78-b8a1-b469842139fa}")
    (extension "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
  ];

in

{
  home-manager.users.${osConfig.younix.user.username}.home.packages = [
    (pkgs.wrapFirefox
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser-unwrapped
      {
        # Extra Prefrerences
        extraPrefs = lib.concatLines (
          # Locked preferences ----------------------------
          (lib.mapAttrsToList (
            name: value: "lockPref(${lib.strings.toJSON name}, ${lib.strings.toJSON value});"
          ) lockedPrefs)

          # Overwritable default preferences --------------
          ++ (lib.mapAttrsToList (
            name: value: "defaultPref(${lib.strings.toJSON name}, ${lib.strings.toJSON value});"
          ) defaultPrefs)
        );

        # EXTRA POLICIES ======================================================
        # Enterprise policies independent from user profile

        extraPolicies = {

          # Privacy ---------------------------------------
          DisableTelemetry = true;

          #
          ExtensionSettings = builtins.listToAttrs extensions;

          # Search Engines --------------------------------
          SearchEngines = {

            # Default search engine
            Default = "Brave Search";

            # Additional search engines
            Add = [

              # General
              {
                Name = "Brave Search";
                URLTemplate = "https://search.brave.com/search?q={searchTerms}";
                IconURL = "https://search.brave.com/favicon.ico";
                Alias = "@bs";
              }

              # NixOS
              {
                Name = "nixpkgs packages";
                URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
                IconURL = "https://wiki.nixos.org/favicon.ico";
                Alias = "@np";
              }
              {
                Name = "NixOS options";
                URLTemplate = "https://search.nixos.org/options?query={searchTerms}";
                IconURL = "https://wiki.nixos.org/favicon.ico";
                Alias = "@no";
              }
              {
                Name = "NixOS Wiki";
                URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
                IconURL = "https://wiki.nixos.org/favicon.ico";
                Alias = "@nw";
              }
              {
                Name = "noogle";
                URLTemplate = "https://noogle.dev/q?term={searchTerms}";
                IconURL = "https://noogle.dev/favicon.ico";
                Alias = "@ng";
              }

              # Home Manager
              {
                Name = "Home Manager Options";
                URLTemplate = "https://home-manager-options.extranix.com/?query={searchTerms}";
                IconURL = "https://home-manager-options.extranix.com/favicon.ico";
                Alias = "@ho";
              }

              # Code Hosting
              {
                Name = "GitHub";
                URLTemplate = "https://github.com/search?q={searchTerms}";
                IconURL = "https://github.githubassets.com/favicons/favicon.svg";
                Alias = "@gh";
              }

            ];

          };

        };

      }
    )

  ];

}
