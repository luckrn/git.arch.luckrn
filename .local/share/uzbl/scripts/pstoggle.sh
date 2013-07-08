#!/bin/sh
#Plugin/Javascript toggling script for uzbl (www.uzbl.org)
#
#Usage: Add \@scripts_status and \@plugins_status to your status_format variable,
#then use the key bindings below.
#@cbind :pt = spawn @scripts_dir/pstoggle.sh \@disable_plugins \@disable_scripts plugins
#@cbind :st = spawn @scripts_dir/pstoggle.sh \@disable_plugins \@disable_scripts scripts
#
#To get the status bar text at uzbl startup, add this at the bottom of your config:
#spawn @scripts_dir/pstoggle.sh \@disable_plugins \@disable_scripts

# save current states
p_off=$8
s_off=$9

if [ $10 = plugins ]; then # if we are toggling plugins
if [ $p_off = 1 ]; then
echo "set disable_plugins = 0" > $4 # send new state to uzbl
p_off=0 # update current state
else
echo "set disable_plugins = 1" > $4
p_off=1
fi
echo "reload" > $4 # tell uzbl to reload page

else if [ $10 = scripts ]; then
if [ $s_off = 1 ]; then
echo "set disable_scripts = 0" > $4
s_off=0
else
echo "set disable_scripts = 1" > $4
s_off=1
fi
echo "reload" > $4
fi
fi
# Add green or red text in status bar depending on plugin/script status
if [ $p_off = 1 ]; then
echo "set plugins_status = <span foreground='#FF0000'>plugins</span>" > $4
else
echo "set plugins_status = <span foreground='#00FF00'>plugins</span>" > $4
fi

if [ $s_off = 1 ]; then
echo "set scripts_status = <span foreground='#FF0000'>scripts</span>" > $4
else
echo "set scripts_status = <span foreground='#00FF00'>scripts</span>" > $4
fi
