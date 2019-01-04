#!/bin/sh

SPEAKERS="alsa_output.pci-0000_0d_00.3.iec958-stereo"
HEADSET="alsa_output.pci-0000_0d_00.3.analog-stereo"
ACTIVE_SINK=$(pactl list short | grep RUNNING | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,')

if [ "$ACTIVE_SINK" = "4" ]; then
	(
	echo set-default-sink $SPEAKERS
	echo "[*] Switching to Speakers."
	
	pacmd list-sink-inputs |
		grep -E '^\s*index:' |
		grep -oE '[0-9]+' |
		while read input
	do
		echo move-sink-input $input $SPEAKERS
	done
	) | pacmd > /dev/null
	
else
	(
	echo set-default-sink $HEADSET
	echo "[*] Switching to headphones."
	
	pacmd list-sink-inputs |
		grep -E '^\s*index:' |
		grep -oE '[0-9]+' |
		while read input
	do
		echo move-sink-input $input $HEADSET
	done
	) | pacmd > /dev/null
fi

exit 0

