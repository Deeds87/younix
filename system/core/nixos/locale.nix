# file: system/core/nixos/locale.nix

# #############################################################################
#
# Description:
# The locale module configures timezone and language settings.
#
# #############################################################################

{ config, ... }:

let

  timezone = config.younix.system.timezone;

  defaultLocale = config.younix.system.locale;

in

{

  time.timeZone = timezone;

  i18n.defaultLocale = defaultLocale;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = defaultLocale;
    LC_IDENTIFICATION = defaultLocale;
    LC_MEASUREMENT = defaultLocale;
    LC_MONETARY = defaultLocale;
    LC_NAME = defaultLocale;
    LC_NUMERIC = defaultLocale;
    LC_PAPER = defaultLocale;
    LC_TELEPHONE = defaultLocale;
    LC_TIME = defaultLocale;
  };

}
