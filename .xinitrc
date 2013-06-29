#!/usr/bin/zsh
# {{{ Environment settings
# always anrxc http://git.sysphere.org/dotfiles/tree/xinitrc
errorlog="${HOME}/.xerrors"
# gnupglog="${HOME}/.gnupg/gpg-agent.info"
# }}}
# {{{ Log settings
#
# Always start X11 with a clean log file
if (cp /dev/null "${errorlog}"); then
  chmod 600 "${errorlog}"
  exec >"${errorlog}" 2>&1
  break
fi
# }}}
# {{{ Display settings
#
# Ignore reported display size and force DPI
#xrandr --dpi 96 &
# Brightness level
#xbacklight -set 00 &
# }}}
# # {{{ Resource and keymap settings
# # usermodmap="${HOME}/.Xmodmap"
# # userresources="${HOME}/.Xresources"
userdefaults="${HOME}/.Xdefaults"
# # sysmodmap="/etc/X11/xinit/.Xmodmap"
# # sysresources="/etc/X11/xinit/.Xresources"
# 
# 
# # Merge system and user resources and keymaps
# # [[ -r "${sysresources}" ]]  && xrdb -merge "${sysresources}"
# # [[ -r "${sysmodmap}" ]]     && xmodmap "${sysmodmap}"
# # [[ -r "${userresources}" ]] && xrdb -merge "${userresources}"
# # [[ -r "${usermodmap}" ]]    && xmodmap "${usermodmap}"
[[ -r "${userdefaults}" ]]    && xrdb -merge "${userdefaults}"
# }}}
# {{{ Input settings
# 
# Keyboard control, repeat delay and repeat rate
# initial delay: 200 et repeat rate: 30 par second
xset r rate 250 30 &

# Pointer control, acceleration and threshold
xset m 0.5 4 &

# }}}
# urxvt daemon {{{
# urxvt en daemon, call it now with urxvtc
if [ -z $(pidof urxvtd) ]; then
    urxvtd -q -f -o
  fi
#}}}
# font ProFont
# revoir http://ccrow.net/?m=200605
# dl chez tobias-jung.de puis extract dans ~/.fonts puis gzip *.pcf puis mkfontdir puis xset:
# pour la font Terminus (https://wiki.archlinux.org/index.php/Fonts)
#sudo /usr/bin/xset +fp /usr/share/fonts/local &
#/usr/bin/xset +fp /home/luke/.fonts &
#sudo /usr/bin/xset fp rehash &
# no beep sound in urxvt
/usr/bin/xset b off
#/usr/bin/hsetroot -solid "#343434"
#/usr/bin/hsetroot -solid "#3f3f3f"
/usr/bin/hsetroot -solid "#000000"
/usr/bin/xcompmgr &
#
/usr/bin/setxkbmap fr bepo &
# pour le typematrix pour le V.num, bordel g cherché 1 moment...
/usr/bin/numlockx on &
mpd &
# iptables_init et pgl pas systemctl
#/home/luke/bin/iptables_init &
#sudo pglcmd start &
#sudo /home/luke/bin/vpnauto > /dev/null &
##exec ck-launch-session dbus-launch --auto-syntax awesome # systemd lance tout seul dbus
# supprimer le cache (et les erreurs) de uzbl
rm -f /home/luke/.cache/uzbl/* &
# vider dans uzbl les cookies
: > /home/luke/.local/share/uzbl/cookies.txt
: > /home/luke/.local/share/uzbl/sessions-cookies.txt
# iptables
#sudo iptables-restore -c < /etc/iptables/iptables.rules
#/home/luke/bin/iptables_init &
#exec ck-launch-session awesome
exec awesome
#exec i3
