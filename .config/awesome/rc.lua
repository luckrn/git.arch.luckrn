-- awesome v3.5.1
-- file: ~/.config/awesome/rc.lua
-- Last edit: sam. 29 juin 2013 16:55:01 CEST 

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
vicious = require("vicious")
local scratch = require("scratch")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}
-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
--beautiful.init("/usr/share/awesome/themes/default/theme.lua")
beautiful.init("/home/luke/.config/awesome/zenburn.lua")

-- This is used later as the default terminal and editor to run.
  terminal = "urxvt"
  editor = os.getenv("EDITOR") or "vim"
  editor_cmd = terminal .. " -e " .. editor

  local home   = os.getenv("HOME")
  local exec   = awful.util.spawn
  local sexec  = awful.util.spawn_with_shell

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.tile,             -- 1
    --awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,      -- 2
    --awful.layout.suit.tile.top,
    awful.layout.suit.fair,             -- 3
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,              -- 4
    --awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,        -- 5
    awful.layout.suit.floating          -- 6 sans la virgule à la fin, bordel!
}

-- logs par Dbus, naughty
-- found here : http://awesome.naquadah.org/wiki/Dbus,_naughty_and_logs
-- set width for naughty windows manually
    naughty_width = 800 -- in pixels
    naughty.config.presets.low.width = naughty_width
    naughty.config.presets.normal.width = naughty_width
    naughty.config.presets.critical.width = naughty_width

-- }}}
-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}
-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, layouts[1])
end
-- }}}
-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- redéfinition des touches des menus (Mod1 W, Mod1 Esc et Mod1 Z) 
-- tout marche bien.
awful.menu.menu_keys = { up    = { "s", "Up" },
                         down  = { "t", "Down" },
                         exec  = { "r", "Return", "Right" },
                         -- the new item
                         enter = { "Right" },
                         --
                         back  = { "c", "Left" },
                         close = { "q", "Escape" },
                       }

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}
-- {{{ Wibox
-- {{{ init
-- {{{ Create a textclock widget
os.setlocale("fr_FR.UTF-8", "time") -- in french, por favor.
mytextclock = awful.widget.textclock(" %a %d %b %R", 61)
--}}}
--{{{ cpu
-- Initialize widget
cpuwidget = awful.widget.graph()
cpuicon = wibox.widget.imagebox(beautiful.widget_cpu)
tzswidget = wibox.widget.textbox()
-- Graph properties
cpuwidget:set_width(50)
cpuwidget:set_background_color("#494B4F")
cpuwidget:set_color("#AECF96")
--cpuwidget:set_gradient_colors({ "#FF5656", "#88A175", "#AECF96" })
-- Register widget
vicious.register(cpuwidget, vicious.widgets.cpu, "$1")
vicious.register(tzswidget, vicious.widgets.thermal, " $1°", 20, { "coretemp.0", "core"} )
--}}}
-- {{{ Reusable separator
separator = wibox.widget.imagebox()
separator:set_image(beautiful.widget_sep)
-- }}}
--{{{ mem
-- Initialize widget
memwidget = awful.widget.progressbar()
memicon = wibox.widget.imagebox(beautiful.widget_mem)
-- Progressbar properties
memwidget:set_width(8)
memwidget:set_height(10)
memwidget:set_vertical(true)
memwidget:set_background_color("#494B4F")
memwidget:set_border_color(nil)
memwidget:set_color("#AECF96")
--memwidget:set_gradient_colors({ "#AECF96", "#88A175", "#FF5656" })
-- Register widget
vicious.register(memwidget, vicious.widgets.mem, "$1", 13)
--}}}
-- {{{ File system usage
fsicon = wibox.widget.imagebox()
fsicon:set_image(beautiful.widget_fs)
-- Initialize widgets
fs = {
  b = awful.widget.progressbar(),
  r = awful.widget.progressbar(),
  h = awful.widget.progressbar(),
  k = awful.widget.progressbar(),
  l = awful.widget.progressbar(),
}
  
-- Progressbar properties
for _, w in pairs(fs) do
  w:set_vertical(true)
  w:set_ticks(true)
  w:set_height(14)
  w:set_width(5)
  w:set_ticks_size(2)
  w:set_border_color(beautiful.border_widget)
  w:set_background_color(beautiful.fg_off_widget)
  --###w:set_gradient_colors({ beautiful.fg_widget,
 --   beautiful.fg_center_widget, beautiful.fg_end_widget
  --}) 
  -- Register buttons
--  w.widget:buttons(awful.util.table.join(
--awful.button({ }, 1, function () exec("rox", false) end)
--awful.button({ }, 1, function () exec("tuxcmd", false) end)
--  ))
end
-- Enable caching
vicious.cache(vicious.widgets.fs)
-- Register widgets
vicious.register(fs.b, vicious.widgets.fs, "${/boot used_p}",               599)
vicious.register(fs.r, vicious.widgets.fs, "${/ used_p}",               599)
vicious.register(fs.h, vicious.widgets.fs, "${/home used_p}",           599)
vicious.register(fs.k, vicious.widgets.fs, "${/media/sdb used_p}",     599)
vicious.register(fs.l, vicious.widgets.fs, "${/media/sdc used_p}",     599)
-- }}}
-- {{{ Network usage
dnicon = wibox.widget.imagebox()
upicon = wibox.widget.imagebox()
dnicon:set_image(beautiful.widget_net)
upicon:set_image(beautiful.widget_netup)
-- Initialize widget
netwidget = wibox.widget.textbox()
-- Register widget
vicious.register(netwidget, vicious.widgets.net, '<span color="'
    .. beautiful.fg_netdn_widget ..'">${eth0 down_kb}</span> <span color="'
    .. beautiful.fg_netup_widget ..'">${eth0 up_kb}</span>', 3)
---- }}}
-- {{{ Org-mode agenda

--Infos à la source http://git.sysphere.org/vicious/tree/README#n204
--vicious.widgets.org
--  - provides agenda statistics for Emacs org-mode
--  - takes a table with full paths to agenda files, that will be
--    parsed, as an argument
--  - returns 1st value as count of tasks you forgot to do, 2nd as count
--    of tasks for today, 3rd as count of tasks for the next 3 days and
--    4th as count of tasks to do in the week
-- La semaine flottante et pas du lun au dim en cours:   1-0-3-0
                                --                       ^ ^ ^ ^
                                --                       | | | |
                                --          task passés--° | | °-- <8j après aujourd'hui
                                --           aujourd'hui---° °---les 3 prochains jours


orgicon = wibox.widget.imagebox()
orgicon:set_image(beautiful.widget_org)
-- Initialize widget
orgwidget = wibox.widget.textbox()
-- Configure widget
local orgmode = {
  files = { home.."/org/home.org",
    home.."/org/tweaks.org", home.."/org/work.org",
  },
  color = {
    past   = '<span color="'..beautiful.fg_urgent..'">',
    today  = '<span color="'..beautiful.fg_normal..'">',
    soon   = '<span color="'..beautiful.fg_widget..'">',
    future = '<span color="'..beautiful.fg_netup_widget..'">'
}} -- Register widget
vicious.register(orgwidget, vicious.widgets.org,
  orgmode.color.past..'$1</span>-'..orgmode.color.today .. '$2</span>-' ..
  orgmode.color.soon..'$3</span>-'..orgmode.color.future.. '$4</span>', 601,
  orgmode.files
) -- Register buttons
orgwidget:buttons(awful.util.table.join(
-- pour que ce qui suit marche, il faut définir dans le fichier ~/.emacs la ligne
-- (start server)
-- qui autorise emacsclient ET avoir une instance enacs en cours
-- Bref, c'est nul. Je préfère ma modif .*
  --awful.button({ }, 1, function () exec("emacsclient --eval '(org-agenda-list)'") end),
  --awful.button({ }, 3, function () exec("emacsclient --eval '(make-remember-frame)'") end)
  awful.button({ }, 1, function () exec("urxvt -e vim /home/luke/test.org -s /home/luke/orgmode_aga") end),
  awful.button({ }, 3, function () exec("urxvt -e vim /home/luke/test.org -s /home/luke/orgmode_agL") end)

))
-- }}}
-- {{{ Volume level
volicon = wibox.widget.imagebox()
volicon:set_image(beautiful.widget_vol)
-- Initialize widgets
volbar    = awful.widget.progressbar()
volwidget = wibox.widget.textbox()
-- Progressbar properties
volbar:set_vertical(true):set_ticks(true)
volbar:set_height(12):set_width(8):set_ticks_size(2)
volbar:set_background_color(beautiful.fg_off_widget)
--volbar:set_gradient_colors({ beautiful.fg_widget,
--   beautiful.fg_center_widget, beautiful.fg_end_widget
--}) 
-- Enable caching
vicious.cache(vicious.widgets.volume)
-- Register widgets
vicious.register(volbar,    vicious.widgets.volume,  "$1",  2, "Master")
vicious.register(volwidget, vicious.widgets.volume, " $1%", 2, "Master")
-- Register buttons
--volbar.widget:buttons(awful.util.table.join(
--   awful.button({ }, 1, function () exec("urxvt -e alsamixer") end),
--   awful.button({ }, 3, function () exec("amixer sset Master toggle") end),
--   awful.button({ }, 4, function () exec("amixer -q set Master 2dB+", false) end),
--   awful.button({ }, 5, function () exec("amixer -q set Master 2dB-", false) end)
--)) -- Register assigned buttons
--volwidget:buttons(volbar.widget:buttons())
-- }}}
--{{{ mpd
-- Initialize widget
mpdwidget = wibox.widget.textbox()
-- Register widget
vicious.register(mpdwidget, vicious.widgets.mpd,
function (widget, args)
  if args["{state}"] == "Stop" then 
    return " - "
  else 
    return args["{Artist}"]..' - '.. args["{Title}"]
  end
end, 10)
--}}}
--}}}

--{{{ set wibox TOP
-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- {{{Create the wibox
    --mywibox[s] = awful.wibox({ position = "top", screen = s, height = 12 })
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = 12, 
                               fg = beautiful.fg_normal,
                               bg = beautiful.bg_normal,
                               border_color = beautiful.border_wibox,
                               border_width = 1
                               })
    --}}}
    -- {{{Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mylayoutbox[s]) -- moved !
    left_layout:add(mypromptbox[s])
    -- }}}
    -- {{{Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    -- cpu
    right_layout:add(separator)
    right_layout:add(cpuicon)
    right_layout:add(cpuwidget)
    right_layout:add(tzswidget)
    -- mem
    right_layout:add(separator)
    right_layout:add(memicon)
    right_layout:add(memwidget)
    -- hd
    right_layout:add(separator)
    right_layout:add(fsicon)
    right_layout:add(fs.b)
    right_layout:add(fs.r)
    right_layout:add(fs.h)
    right_layout:add(fs.k)
    right_layout:add(fs.l)
    -- net
    right_layout:add(separator)
    right_layout:add(dnicon)
    right_layout:add(netwidget)
    right_layout:add(upicon)
    --mpd
    right_layout:add(separator)
    right_layout:add(mpdwidget)
    -- volbar
    right_layout:add(volicon)
    right_layout:add(volbar)
    right_layout:add(volwidget)
    -- orglendar
    right_layout:add(separator)
    right_layout:add(orgicon)
    right_layout:add(orgwidget)
    -- clock
    right_layout:add(separator)
    right_layout:add(mytextclock)
--    right_layout:add(mylayoutbox[s])
    -- }}}
    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
--}}}

--}}}
-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}
-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "t",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "s",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "t", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "s", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "t", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "s", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- {{{{ Add-on luke
    -- dmenu
    awful.key({ modkey, "Alt"},            "F2",     function ()
    awful.util.spawn("dmenu_run -i -p 'Run command:' -fn '-*-profont-*-*-normal-*-11-*-*-*-*-*-iso8859-*' -nb '" .. 
        beautiful.bg_normal .. "' -nf '" .. beautiful.fg_normal ..
        "' -sb '" .. beautiful.bg_focus .. 
        "' -sf '" .. beautiful.fg_focus .. "'")
    end),

    -- printcreens par la «touche Impr écran»
    -- xev sur cette touche donne Print. c'est le nom de cette touche
    awful.key({ }, "Print", function () awful.util.spawn("scrot -e 'mv $f ~/screenshots/ 2>/dev/null'") end),

    -- list all fenêtres même minimizées
    awful.key({ modkey,      }, "z",
      function ()
        awful.menu.menu_keys.down = { "t", "Down", "Alt_L" }
        local cmenu = awful.menu.clients({width = 500}, {keygrabber=true, coords={x=525, y=330}})
      end),

    -- luke toggle wibox visibility
    awful.key({ modkey }, "b",
      function ()
        mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
      end),

    -- luke revelation, fenêtre en mosaïque
    --awful.key({ modkey }, "e",  revelation.revelation),

    -- luke add application switcher
    awful.key({ modkey }, "Escape",
      function ()
        -- If you want to always position the menu on the same place set coordinates
        awful.menu.menu_keys.down = { "t", "Down", "Alt_L" }
        local cmenu = awful.menu.clients({width=500}, { keygrabber=true, coords={x=525, y=330} })
      end),

    -- soft & fonctions
    awful.key({ modkey }, "d", function () awful.util.spawn("dwb") end),
    awful.key({ modkey }, "u", function () awful.util.spawn("uzbl") end),
    awful.key({ modkey,"Control"}, "f",         function () awful.util.spawn("firefox -P default") end),
    awful.key({ modkey,"Control"}, "v",         function () awful.util.spawn("vlc") end),
    awful.key({ modkey,"Shift"}, "n",         function () awful.util.spawn("urxvt -e ncmpcpp") end),
    awful.key({ modkey,}, "F11",                function () awful.util.spawn("sudo systemctl poweroff") end),
    -- indispensable
    --awful.key({ modkey },"x",                   function () teardrop("urxvt", "bottom", "center", 0.95, 0.4, false) end),
    awful.key({ modkey },"x",                   function () scratch.drop("urxvt", "bottom", "center", 0.8, 0.30) end),

    -- luke son clavier Typematrix
      awful.key({ }, "XF86AudioLowerVolume", function () awful.util.spawn("amixer -q sset Master 2dB-") end),
      awful.key({ }, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer -q sset Master 2dB+") end),
      awful.key({ }, "XF86AudioMute", function () awful.util.spawn("amixer -q sset Master toggle") end),
    -- luke son mpc avant, arrière,...
    -- mpc paquet supp «minimalist command line interface for MPD»
      awful.key({ }, "XF86AudioNext",function () awful.util.spawn( "mpc next" ) end),
      awful.key({ }, "XF86AudioPrev",function () awful.util.spawn( "mpc prev" ) end),
      awful.key({ }, "XF86Forward",function () awful.util.spawn( "mpc play" ) end),
      awful.key({ }, "XF86Back",function () awful.util.spawn( "mpc pause" ) end),
    -- luke lock the screen
      awful.key({ modkey, "Control" }, "l", function () awful.util.spawn(lock) end),
      --}}}


    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "h", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "r",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "c",     function () awful.tag.incmwfact(-0.05)    end),
    --
    awful.key({ modkey, "Shift"   }, "c",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "r",     function () awful.tag.incnmaster(-1)      end),
    --
    awful.key({ modkey, "Control" }, "c",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "r",     function () awful.tag.incncol(-1)         end),
    --
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore), -- minimize windows

    -- Prompt
    -- Run tout court...
    awful.key({ modkey },            "F1",     function () mypromptbox[mouse.screen]:run() end),
    -- Run in terminal (sans lancer urxvt) :
    awful.key({ modkey, "Shift"   }, "r",
      function ()
        awful.prompt.run({ prompt = "Run in terminal: " },
        mypromptbox[mouse.screen].widget,
          function (...) awful.util.spawn(terminal .. " -e " .. ...) end,
        awful.completion.shell,
        awful.util.getdir("cache") .. "/history")
      end),

    awful.key({ modkey }, "F4",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "x",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber))
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}
-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    --{ rule = { class = "vlc" },
    --  properties = { floating = true } },
    { rule = { class = "Vlc" },
      properties = { floating = true }, callback = awful.placement.centered },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    --{ rule = { class = "gimp" },
    --  properties = { floating = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
-- }}}
-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local title = awful.titlebar.widget.titlewidget(c)
        title:buttons(awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                ))

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(title)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus  c.opacity = 1 end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal c.opacity = 0.8 end)

-- autostart

--awful.util.spawn_with_shell("/home/luke/bin/mount_freebox") -- après le fstab (noauto) et avec un coup de notify-send
-- }}}
