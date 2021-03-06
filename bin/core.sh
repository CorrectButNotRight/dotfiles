#!/bin/sh

. ~/.config/profile
# export GTK_IM_MODULE=fcitx
# export QT_IM_MODULE=fcitx
# export XMODIFIERS=@im=fcitx

# special resets
redshift -x

# kill services
killall dunst 
pkill redshift
# pkill onedrive
# pkill xss-lock
# pkill udisksctl
# pkill nm-applet
# tmux kill-server
# killall -q fcitx
# setxkbmap -option
# killall -q xscreensaver
# killall -q sleep_timer.sh
# killall -q emacs
pkill udiskie

# services
# ~/bin/asound.sh off
# ~/bin/screens.sh

~/bin/wallpaper.sh
# xcalib -d :0 "/usr/share/color/icc/Lenovo T520.icm" &
xsetroot -cursor_name left_ptr &
redshift &
# xscreensaver &

#xset m 4/5 1
dunst &
[ -z "$(pidof urxvtd)" ] && urxvtd &
[ $(ps ax | grep "emacs --daemon" | wc -l) -le 1 ] && emacs --daemon &
# emacs --daemon &
[ -z "$(pidof xfce4-power-manager)" ] && xfce4-power-manager &
# fcitx &
# udisksctl monitor &
# find setxkbmap options in /usr/share/X11/xkb/rules/base.lst
setxkbmap -option caps:escape_shifted_capslock
# setxkbmap -option caps:super
# xcape -e 'Super_L=Escape' -t 200
# setxkbmap -option ctrl:nocaps
udiskie -t &
# xcape -e 'Control_L=Escape' -t 200
# tmux new -s andrew -d 
# onedrive -m &
# xss-lock -l ~/bin/lock.sh & 
# light-locker &
# light-locker --lock-on-suspend --lock-after-screensaver=60 --idle-hint &
# light-locker --late-locking --lock-on-suspend --lock-after-screensaver=25 &
nm-applet &
keepassxc &

# instructions
# nmcli -g SSID device wifi list > "$XDG_CACHE_HOME"/ssidlist
# sleep_timer.sh &

# jack_control start
# qjackctl &
# cadence-session-start -s &
