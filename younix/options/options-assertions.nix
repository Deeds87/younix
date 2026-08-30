# file: younix/options-assertions.nix

# #############################################################################
#
# Description:
# Validates the youNIX configuration.
#
# Ensures that incompatible or incomplete option combinations are rejected
# during evaluation.
#
# #############################################################################

{ config, ... }:

let

  # Local variables ---------------------------------------
  virtualization = config.younix.features.virtualization;

  # INIT Actions ==============================================================

  validateInitAction = item: {

    assertion =

      if item.action == "copy" then
        item.source != null

      else if item.action == "create-directory" then
        item.source == null

      else if item.action == "write-file" then
        item.source == null

      else
        false;

    message =

      if item.action == "copy" then
        "initActions: action \"copy\" requires a source."

      else if item.action == "create-directory" then
        "initActions: action \"create-directory\" must not define a source."

      else if item.action == "write-file" then
        "initActions: action \"write-file\" must not define a source "

      else
        "initActions: Unknown action \"${item.action}\".";

  };

  # VIRTUALIZATION FEATURE ====================================================

  validateVirtualization = [

    {
      assertion = virtualization.mode != "host" || virtualization.backends != [ ];

      message = "virtualization: host mode requires at least one backend.";
    }

    {
      assertion = virtualization.mode != "guest" || builtins.length virtualization.backends == 1;

      message = "virtualization: guest mode requires exactly one backend.";
    }

    {
      assertion =
        !builtins.elem "virt-manager" virtualization.frontends
        || (virtualization.mode == "host" && builtins.elem "qemu" virtualization.backends);

      message = "virtualization: virt-manager requires host mode and the qemu backend.";
    }

    {
      assertion = virtualization.mode != "guest" || virtualization.frontends == [ ];

      message = "virtualization: guest mode does not support frontends.";
    }

  ];

in

{

  assertions = validateVirtualization ++ map validateInitAction config.younix.initActions;

}
