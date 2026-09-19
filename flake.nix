# file: flake.nix

# #############################################################################
#
# YouNIX flake
#
# Description:
# YouNIX - A flake to make NixOS yours.
#
# Some hints:
# - Arch:
#     The system arch is read from 'younix-config.nix'.
# - Hostname:
#     The hostname is read from 'younix-config.nix'.
# - Home-Manager setup:
#     The setup is offloaded to 'home.nix' to avoid hardcoding usernames.
#
# #############################################################################

{

  description = "YouNIX flake";

  # INPUTS ====================================================================
  #
  # - nixpkgs:                  Source of nix packages
  # - home-manager:             Source of home-manager
  # - zen-browser:              Zen-Browser flake
  # - dms:                      Dank Material Shell
  # - dms-plugin-registry:      DMS-Plugin-Registry flake
  # - dankcalendar:             Dankcalendar flake
  # - dgop:                     DGOP flake
  # - base46                    Base46 theme (neovim)
  # - helix:                    Helix editor flake
  # - nixvim                    Nixvim flake

  inputs =

    {

      # Nix packages --------------------------------------
      # Commenting the nixpkgs branch you do NOT want to use.

      # stable (regular release version) - check version number
      # nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

      # unstable (rolling)
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

      # Home-Manager --------------------------------------
      home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # Zen-Browser ---------------------------------------
      zen-browser = {
        url = "github:youwen5/zen-browser-flake";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # Dank Material Shell -------------------------------
      dms = {
        url = "github:AvengeMedia/DankMaterialShell/stable";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # DMS Plugins ---------------------------------------

      dms-plugin-registry = {
        url = "github:AvengeMedia/dms-plugin-registry";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # Dankcalendar --------------------------------------
      dcal = {
        url = "github:AvengeMedia/dankcalendar";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # dgop ----------------------------------------------
      dgop = {
        url = "github:AvengeMedia/dgop";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # base46 --------------------------------------------
      base46 = {
        url = "github:AvengeMedia/base46";
        flake = false;
      };

      # Helix ---------------------------------------------
      helix = {
        url = "github:helix-editor/helix/master";
        inputs.nixpkgs.follows = "nixpkgs";
      };

      # Nixvim --------------------------------------------
      nixvim = {
        url = "github:nix-community/nixvim";
      };

    };

  # OUTPUTS ===================================================================
  #
  # The whole input attribute set is available under 'inputs'.
  # Selected inputs are also destructured for direct access below.
  #
  # - self:              The flake itself
  # - nixpkgs:           Nix packages input
  # - home-manager:      Home-Manager input

  outputs =

    inputs@{
      self,
      nixpkgs,
      home-manager,
      nixvim,
      ...
    }:

    let
      # Makes values from 'younix-config.nix' accessible in outputs
      younixSettings = import ./younix-config.nix;
    in

    {

      # Entry point for 'default' host --------------------

      nixosConfigurations."${younixSettings.system.hostname}" = nixpkgs.lib.nixosSystem {

        # Target system architecture
        system = younixSettings.system.arch;

        # ------------------------------

        # Pass the flake context to NixOS modules.
        # 'self' allows modules to reference the current flake itself,
        # while 'inputs' provides access to external flake inputs.
        specialArgs = {
          inherit self;
          inherit inputs;
        };

        # -----------------------------

        # Modules to build the system
        modules = [

          # Entry point for the main configuration
          ./configuration.nix

          # Enable Home-Manager as a NixOS module
          home-manager.nixosModules.home-manager
          {

            # Modules shared with all home-manager users
            home-manager.sharedModules = [
              nixvim.homeModules.nixvim
            ];

            # Pass the flake context to Home-Manager modules.
            # This allows modules to access the current flake
            # and its inputs when required.
            home-manager.extraSpecialArgs = {
              inherit self;
              inherit inputs;
            };

          }

        ];

      };

    };

}
