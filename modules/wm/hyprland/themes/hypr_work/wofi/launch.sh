#!/bin/sh

if pgrep -x "wofi" > /dev/null; then
  exit
else
  wofi --show drun -I  -c ~/.config/hypr/themes/hypr_work/wofi/config -s ~/.config/hypr/themes/hypr_work/wofi/style.css
fi

