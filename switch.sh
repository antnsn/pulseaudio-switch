#!/bin/sh

DEVICE='3'
ACTIVE_SINK=$(pacmd list-sinks | grep 'active port: <analog-output-lineout>' | awk '{ print $3 }')

if [ "$ACTIVE_SINK" = "<analog-output-lineout>" ]; then
	echo "[*] Switching to Speakers."
	pacmd set-card-profile $DEVICE output:iec958-stereo
else
	echo "[*] Switching to headphones."
	pacmd set-card-profile $DEVICE output:analog-stereo
fi

exit 0


