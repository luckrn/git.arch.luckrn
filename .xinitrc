
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# fonts
Xft.dpi:        96
Xft.antilias:   true
Xft.rgba:       rgb
Xft.hinting:    true
Xft:hintstyle:  hintslight
Xft.autohint:   false
Xft.lcdfilter:  lcddefault

# merge
[[ -f "~/.Xdefaults" ]] && xrdb -merge ~/.Xdefaults &

#eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
#export GPG_AGENT_INFO SSH_AUTH_SOCK

# Disable DPMS turning off the screen
xset -dpms &
#xset s off &

# silence
xset -b &

# curseur souris pour xmonad
xsetroot -cursor_name left_ptr


# Enable zapping (C-A-<Bksp> kills X)
setxkbmap -option terminate:ctrl_alt_bksp &


# Enforce correct locales from the beginning:
# LC_ALL is unset since it overwrites everything
# LANG=de_DE.UTF-8 is used, except for:
# LC_MESSAGES=C never translates program output
# LC_TIME=en_DK leads to yyyy-mm-dd hh:mm date/time output
unset LC_ALL &
export LANG=fr_FR.UTF-8 &
export LC_MESSAGES=C &
export LC_TIME=fr_FR.UTF-8 &

# Use XToolkit in java applications
##export AWT_TOOLKIT=XToolkit &

# Set background color
xsetroot -solid "#333333" &

# Enable core dumps in case something goes wrong
#ulimit -c unlimited &

# log
errorlog="${HOME}/.xerrors"
# Always start X11 with a clean log file
if (cp /dev/null "${errorlog}"); then
  chmod 600 "${errorlog}"
  exec >"${errorlog}" 2>&1
  break
fi

# souris
xset m 0.5 4 &
xset r rate 300 30 &
xsetroot -cursor_name left_ptr &

# urxvt en daemon NOT: passe par systemd
#if [ -z $(pidof urxvtd) ]; then
#  urxvtd -q -f -o
#fi

# clavier
numlockx on &
setxkbmap fr bepo &

# test ntlmaps dans .zprofil pour le choper depuis le terminal
sudo ntlmaps start &
# plus besoin, voir ~/.zshrc_function  >>> pas sûr pour curl 

# automount usb device with pcmanfm en daemon
#pcmanfm -d &

# cosmetic
transset-df -p -t 0.3 &
xcompmgr &
#compton &
#xsetroot -gray /home/luke/images/pierre.jpg

# volnoti
pgrep volnoti || volnoti &

# sxhkd (sans bsp pour spectrwm)
# juste mpd, les touches volumes (+ - mute), le lock i3lock Alt+l et Alt+F1 (morc-menu)
pgrep sxhkd || sxhkd &


# F1 log au démarrage
#tilda &
#pgrep conky || conky &
#remind -z -k'gxmessage -title "reminder" %s &' ~/.reminders &

#exec awesome

# notification avec dunst
dunst &

# bspwm
#xsetroot -cursor_name left_ptr &
#feh --bg-fill0 /home/luke/images/goddess-1920x1080.jpg &
#nitrogen --restore &
#conky -c /home/luke/.conky_heure &
#sxhkd &   #déja dans bspwm
#exec bspwm

xscreensaver &
#pgrep redshift || redshift -l 47.99727:-4.09867 &
#exec spectrwm

#exec subtle

#exec herbstluftwm --locked

#exec xmonad

exec awesome


