#!/bin/sh

#if [[ "$#" -ne 2 ]] ; then
#	exit 1
#fi

op=$1
in=$2

case $op in
	focusnode)
		if [ $(bspc query -D -d) = $(bspc query -D -d "$in") ] ; then
			bspc desktop -f last
		else
			bspc desktop -f "$in"
		fi
		;;
  resize) # rework with cases (directions) and function (encapsulate control flow)
		pix=20
		h=left; j=bottom; k=top; l=right
		dimensions="-${pix};0;${pix};0;0;${pix};0;-${pix}"
		directions="${h}=1;${j}=2;${l}=3;${k}=4"
		index=$(echo $directions | sed "s/.*${in}=//;s/\;.*//")
		pair=$(( $index + 4 ))
		first=$(echo $dimensions | cut -d ';' -f $index)
		second=$(echo $dimensions | cut -d ';' -f $pair)
		bspc node -z $in $first $second && exit 0
    if [ -n "$(bspc query -N -n focused.tiled)" ] ; then
			opposite="${l};${k};${h};${j}"
			newdir=$(echo $opposite | cut -d ';' -f $index)			
			bspc node -z $newdir $first $second
		fi
		;;
	focusDesktop)
		bspc desktop -f $(bspc query -D --names | dmenu -i -p "Go to desktop")
		;;
	addDesktop)
		default=">>"
		name=$(echo "$default" | dmenu -p "Enter new desktop name")
		[ "$name" = "$default" ] && name=$(( $(bspc query -D --names | grep -E "[0-9]+" | sort -nr | head -n1) + 1))
		while [ $(bspc query -D --names | grep $name | wc -l) -gt 0 ] ; do
			name=$(echo "$default" | dmenu -p "Desktop already exists - use unique name")
		done
		[ -z "$name" ] && exit 1
		bspc monitor -a $name
		~/bin/polybar/polybar-bsp.sh
		;;
	removeDesktop)
		default="<<"
		name=$(echo "$default\n$(bspc query -D --names)" | dmenu -p "Remove desktop")
		[ "$name" = "$default" ] && name=$(bspc query -D --names | tail -n1)
		[ -z "$name" ] && exit 1
		bspc desktop $name -r
		;;	
	yt)
		bspc rule -a firefox desktop="^9"
		firefox --new-window youtube.com &
		sleep 1
		bspc rule -r firefox
		;;
	hide)
		hidden=$(bspc query -N -d | xargs -I _id bspc query -N -n _id.hidden)
		marked=$(bspc query -N -d | xargs -I _id bspc query -N -n _id.marked)
		if [ -z "$hidden" ] ; then
			if [ -z "$marked" ] ; then
				bspc node -g hidden=on
			else
				echo "$marked" | xargs -I _id -n 1 bspc node _id -g hidden=on
				echo "$marked" | xargs -I _id -n 1 bspc node _id -g marked=off
			fi
		else
			echo "$hidden" | xargs -I _id -n 1 bspc node _id -g hidden=off
		fi
		;;
  full)
		hidden=$(bspc query -N -d | xargs -I _id bspc query -N -n _id.hidden)
    full=$(bspc query -N -n $(bspc query -N -n).fullscreen)
    unfoc=$(bspc query -N -d | xargs -I _id bspc query -N -n _id.\!focused.\!ancestor_of)
    if [ -z "$full" ]; then
      echo "$unfoc" | xargs -I _id -n 1 bspc node _id -g hidden=on
      bspc node -t \~fullscreen
    else
      bspc node -t \~fullscreen
      echo "$hidden" | xargs -I _id -n 1 bspc node _id -g hidden=off
    fi
    ;;
	rotate)
		marked=$(bspc query -N -d | xargs -I _id bspc query -N -n _id.marked)
		if [ -z "$marked" ] ; then
			bspc node @/ -R "$in"
		#else
		#	echo "$marked" | xargs -I _id bspc node _id -R 
		fi
		;;
esac

exit $?