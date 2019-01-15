#!/usr/bin/env bash

[ -f ~/.Xresources ] && xrdb -merge ~/.Xresources
## Telas sobre postas
#xrandr --output HDMI1 --primary --mode 1366x768 --pos 0x0 --rotate normal --output VIRTUAL1 --off --output eDP1 --mode 1366x768 --pos 0x0 --rotate normal &

## Monitor Fixo a esquerda
xrandr --output HDMI1 --primary --mode 1366x768 --pos 1366x0 --rotate normal --output VIRTUAL1 --off --output eDP1 --mode 1366x768 --pos 0x0 --rotate normal &

## Monitor fixo a direita
#xrandr --output HDMI1 --primary --mode 1366x768 --pos 0x0 --rotate normal --output VIRTUAL1 --off --output eDP1 --mode 1366x768 --pos 1366x0 --rotate normal &

## Teclado
xbindkeys
# export PATH="${PATH}:~/scripts"
## Barra de Statuts

### Config 1

#dwmstatus 2>&1 >/dev/null &

### Config 2

while true; do
        xsetroot -name "`~/scripts/dwm_status`"
            sleep 1
        done &


## Efeitos do Desktop
compton -b -c -C &

## Gerenciador de Wallpaper
nitrogen --restore &

## Windows Manager
exec dwm 
#exec bspwm
#exec qtile
