#!/bin/bash

pactl get-sink-volume @DEFAULT_SINK@ |sed -nE 's/.* ([0-9]+)%.*/\1/p'

pactl subscribe |sed -nu '/change/p' |while read; do
	pactl get-sink-volume @DEFAULT_SINK@ |sed -nE 's/.* ([0-9]+)%.*/\1/p'
done
