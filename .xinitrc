# ~/.xinitrc (modif with DWM) 
# Last modified: dimanche 01/05/2016 at 14:31:28
# vi:syntax=sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

# {{{ Environment settings
errorlog="${HOME}/.xerrors"
# }}}
# {{{ Log settings
# Always start X11 with a clean log file
if (cp /dev/null "${errorlog}"); then
  chmod 600 "${errorlog}"
  exec >"${errorlog}" 2>&1
  break
fi
# }}}

# merge
[[ -f ~/.Xdefaults ]] && xrdb -merge ~/.Xdefaults

## DPMS monitor setting (standby -> suspend -> off) (seconds)
# vu dans /etc/X11/xorg.conf.d/10-monitor.conf

# Disable bell
xset -b &

# Pointer control, acceleration and threshold
xset m 30/10 4 &

# bilan xset: > xset q

# Enable zapping (C-A-<Bksp> kills X)
setxkbmap -option terminate:ctrl_alt_bksp &

# Set background color
# darker as vim zenburn darker
xsetroot -solid "#1f1f1f" &


# bépo
setxkbmap fr bepo &

# verrouillage numérique
# pour le clavier TypeMatrix : touches bleues (avec Fn)
numlockx &

# notify
killall notification-daemon &> /dev/null
#statnot & 
dunst &

# unclutter-xfixes-git hides your X mouse cursor when you do not nett it
pgrep unclutter || unclutter &

# automount usb device par pcmanfm en daemon
pgrep pcmanfm || pcmanfm -d &

pgrep mpd  || mpd &
#pgrep tilda || tilda &
#pgrep compton || compton --config /home/luke/.config/compton/compton.conf -b &
#pgrep compton || compton &

#remind
#remind -fa ~/.reminders &

# del iptables_ipset_... script if restart awesome
#pkill iptables_ipset_
#pgrep conky || conky &
#exec awesome

# i3
#exec i3 -V >> ~/i3log-$(date +'%F-%k-%M-%S') 2>&1

#bspwm
#sxhkd &		# déjà dans ~/.config/bspwm/bspwmrc
#urxvt &
# lancement avec example «loop», see: https://github.com/baskerville/bspwm/tree/master/examples/loop
# compton (script dans ~/bin)
monitoring on &
# cursor
xsetroot -cursor_name left_ptr &
# wallpaper
# the first time, next line in terminal, then (next session) :
sh ~/.fehbg &
#feh --bg-scale ~/images/1476407-decommissioned-navy-ships.jpg &
# drop terminal (run keys: Alt + Ctrl + y)
yeahconsole &
# conky
conky -c ~/.conkyrc &
conky -c ~/.conky_heure &
#exec wm
exec bspwm
