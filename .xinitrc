#!/bin/bash
/usr/local/bin/autorandr.sh
fcitx -d
wmname LG3D
xsetwacom --list devices | sed 's/.*id: \([0-9]*\).*\?/\1/' | xargs -I{} xsetwacom --set {} MapToOutput "LVDS1"
#exec cinnamon
#exec i3
#exec fluxbox
#exec fvwm2
#exec xfwm4
#exec startxfce4
#exec xfce4-session
exec awesome 
#export PYTHONTRACEMALLOC=1
#exec qtile
#exec startlxde
#exec startfluxbox
#exec starte16
#exec blackbox
