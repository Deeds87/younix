# file: system/core/nixos/audio.nix

# #############################################################################
#
# Description:
# The audio module configures the system audio backend.
#
# #############################################################################

{ ... }:

{

  # Disable pulseaudio
  services.pulseaudio.enable = false;

  # Enable realtimekit for low latency
  security.rtkit.enable = true;

  # Enable and setup pipewire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

}
