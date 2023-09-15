#!/bin/sh

# Define the sink names for speakers and headphones
SPEAKERS="alsa_output.pci-0000_0d_00.3.iec958-stereo"
HEADSET="alsa_output.pci-0000_0d_00.3.analog-stereo"

# Get the index of the active audio sink
ACTIVE_SINK=$(pactl list short sinks | grep -E '^(6|7).*$' | awk '{print $1}')

# Function to switch the audio output and move sink inputs
switch_audio_output() {
  local new_sink="$1"
  notify-send "Switching to $new_sink" --icon=dialog-information

  pacmd set-default-sink "$new_sink"
  pacmd list-sink-inputs | grep -E '^\s*index:' | awk '{print $2}' | while read input
  do
    pacmd move-sink-input "$input" "$new_sink"
  done
}

# Perform the audio output switch based on the active sink
case "$ACTIVE_SINK" in
  7) switch_audio_output "$SPEAKERS";;
  6) switch_audio_output "$HEADSET";;
  *) echo "Unknown active sink: $ACTIVE_SINK";;
esac

exit 0
