#!/bin/sh

[ "$#" -lt 1 ] && exit 1
# cachedir=${XDG_CACHE_HOME:-"$HOME/.cache"}
cachedir=${XDG_DATA_HOME:-"$HOME/.local/share"}
if [ -d "$cachedir" ]; then
	cache=$cachedir/dmenu_run
	historyfile=$cachedir/dmenu_history
else			# if no xdg dir, fall back to dotfiles in ~
	cache=$HOME/.dmenu_cache
	historyfile=$HOME/.dmenu_history
fi

export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
IFS=:
if stest -dqr -n "$cache" $PATH; then
	stest -flx $PATH | sort -u > "$cache"
fi
unset IFS

	# | dmenu "$@" \
	# | rofi -dmenu -i "$@" \
awk -v histfile=$historyfile '
	BEGIN {
		while( (getline < histfile) > 0 ) {
			sub("^[0-9]+\t","")
			print
			x[$0]=1
		}
	} !x[$0]++ ' "$cache" \
	| "$@" \
	| awk -v histfile=$historyfile '
		BEGIN {
			FS=OFS="\t"
			while ( (getline < histfile) > 0 ) {
				count=$1
				sub("^[0-9]+\t","")
				fname=$0
				history[fname]=count
			}
			close(histfile)
		}

		{
			history[$0]++
			print
		}

		END {
			if(!NR) exit
			for (f in history)
				print history[f],f | "sort -t '\t' -k1rn >" histfile
		}
	' \
	| while read cmd; do ${SHELL:-"/bin/sh"} -c "$cmd" & done
