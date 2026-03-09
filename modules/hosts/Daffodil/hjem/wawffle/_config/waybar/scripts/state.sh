#!/usr/bin/env bash

clients=$(hyprctl -j activewindow)

isFloating=$(echo "$clients" | jq -r '.floating')
fullscreen=$(echo "$clients" | jq -r '.fullscreen')

state=""

if [[ "$isFloating" == "true" ]]; then
state="[Floating]"
fi

if [[ "$fullscreen" == "2" ]]; then
state="[Fullscreen]"
elif [[ "$fullscreen" == "1" ]]; then
   state="[Maximized]"
fi

echo "{\"text\" : \"$state\"}"
