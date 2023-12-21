#!/bin/bash

# nf-fa-volume_up,              f028,    
# nf-fa-volume_down,            f027,    
# nf-md-volume_high,            f057e,  󰕾 
# nf-md-volume_medium,          f0580,  󰖀 
# nf-md-volume_low,             f057f,  󰕿 
# nf-fa-volume_off,             f026,    
# nf-md-volume_off,             f0581,  󰖁 
# nf-md-volume_variant_off,     f0e08,  󰸈 

# nf-md-monitor_speaker,        f0f5f,  󰽟 
# nf-md-monitor_speaker_off,    f0f60,  󰽠 
# nf-md-speaker,                f04c3,  󰓃 
# nf-md-speaker_bluetooth,      f09a2,  󰦢 
# nf-md-speaker_multiple,       f0d38,  󰴸 
# nf-md-speaker_off,            f04c4,  󰓄 
# nf-md-speaker_wireless,       f071f,  󰜟 

# nf-fa-headphones,             f025,    
# nf-md-headphones,             f02cb,  󰋋 
# nf-md-headphones_bluetooth,   f0970,  󰥰 
# nf-md-headphones_off,         f07ce,  󰟎 

function get-volume {
wpctl get-volume @DEFAULT_AUDIO_SINK@ |while read _ volume b; do
	muted=false

	if [ b = "MUTED" ]; then
		muted=true
	fi

	echo "{\"volume\":$volume,\"muted\":$muted}"
done
}

# pactl get-sink-volume @DEFAULT_SINK@ |sed -nE 's/.* ([0-9]+)%.*/\1/p'
get-volume

if [[ "--watch" != "$1" ]]; then
	exit 0
fi

pactl subscribe |sed -nu '/change/p' |while read; do
	# pactl get-sink-volume @DEFAULT_SINK@ |sed -nE 's/.* ([0-9]+)%.*/\1/p'
	get-volume
done
