-------------------------------
--  "Zenburn" awesome theme  --
--    By Adrian C. (anrxc)   --
--    License:  GNU GPL v2   --
--  _        _
-- | |__ ___| |_
-- | '_ \_  / '_ \
-- | |_) / /| | | |
-- |_.__/___|_| |_|
-- 
-- file: zenburn.lua
-- last edit: sam. 29 juin 2013 16:57:35 CEST 
-------------------------------

-- {{{ Main
theme = {}
--theme.confdir       = awful.util.getdir("config")
--theme.wallpaper_cmd = { "/usr/bin/nitrogen --restore" }
--theme.wallpaper_cmd = { "awsetbg /usr/share/awesome/themes/zenburn/zenburn-background.png" }
--theme.wallpaper = "/home/luke/images/wallpaper/matrix.jpg"
-- }}}
-- {{{ Styles
theme.font      = "profont 8"
--theme.font      = "anonymous pro 9"
--theme.font = "inconsolata 11"
--theme.font = "Mensch for Powerline 8"

-- {{{ Colors
theme.fg_normal = "#DCDCCC"
theme.fg_focus  = "#F0DFAF"
theme.fg_urgent = "#CC9393"
theme.fg_minimize   = theme.bg_normal
theme.bg_normal = "#3F3F3F"
theme.bg_focus  = "#1E2320"
theme.bg_urgent = theme.bg_normal
theme.bg_systray = theme.bg_normal
theme.bg_minimize   = theme.bg_normal
-- }}}

-- {{{ Borders
theme.border_width  = 1
--theme.border_focus  = "#6F6F6F"
theme.border_wibox= "#6F6F6F"
theme.border_focus  = "#878776"
theme.border_normal = theme.bg_normal
theme.border_marked = theme.fg_urgent
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = theme.bg_normal
theme.titlebar_bg_normal = theme.bg_normal
-- theme.titlebar_[normal|focus]
-- }}}

-- {{{ Widgets
theme.fg_widget        = "#AECF96"
theme.fg_center_widget = "#88A175"
theme.fg_end_widget    = "#FF5656"
theme.fg_off_widget    = "#494B4F"
theme.fg_netup_widget  = "#7F9F7F"
theme.fg_netdn_widget  = theme.fg_urgent
theme.bg_widget        = theme.bg_normal
theme.border_widget    = theme.bg_normal
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = theme.fg_urgent
-- theme.mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Tooltips
-- theme.tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- }}}

-- {{{ Taglist and Tasklist
-- theme.[taglist|tasklist]_[bg|fg]_[focus|urgent]
-- }}}

-- {{{ Menu
-- theme.menu_[bg|fg]_[normal|focus]
-- theme.menu_[height|width|border_color|border_width]
theme.menu_height = 15
theme.menu_width  = 400
-- }}}
-- }}}
-- {{{ Icons
--
-- {{{ Taglist icons
theme.taglist_squares_sel   = "/home/luke/.config/awesome/icons/taglist/sel.png"
theme.taglist_squares_unsel = "/home/luke/.config/awesome/icons/taglist/unsel.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc icons
theme.awesome_icon           = "/home/luke/.config/awesome/icons/awesome.png"
theme.menu_submenu_icon      = "/usr/share/awesome/themes/default/submenu.png"
theme.tasklist_floating_icon = "/usr/share/awesome/themes/default/tasklist/floatingw.png"
-- }}}

-- {{{ Layout icons
theme.layout_tile       = "/home/luke/.config/awesome/icons/layouts/tile.png"
theme.layout_tileleft   = "/home/luke/.config/awesome/icons/layouts/tileleft.png"
theme.layout_tilebottom = "/home/luke/.config/awesome/icons/layouts/tilebottom.png"
theme.layout_tiletop    = "/home/luke/.config/awesome/icons/layouts/tiletop.png"
theme.layout_fairv      = "/home/luke/.config/awesome/icons/layouts/fairv.png"
theme.layout_fairh      = "/home/luke/.config/awesome/icons/layouts/fairh.png"
theme.layout_spiral     = "/home/luke/.config/awesome/icons/layouts/spiral.png"
theme.layout_dwindle    = "/home/luke/.config/awesome/icons/layouts/dwindle.png"
theme.layout_max        = "/home/luke/.config/awesome/icons/layouts/max.png"
theme.layout_fullscreen = "/home/luke/.config/awesome/icons/layouts/fullscreen.png"
theme.layout_magnifier  = "/home/luke/.config/awesome/icons/layouts/magnifier.png"
theme.layout_floating   = "/home/luke/.config/awesome/icons/layouts/floating.png"
-- }}}

-- {{{ Widget icons
theme.widget_cpu    = "/home/luke/.config/awesome/icons/cpu.png"
theme.widget_bat    = "/home/luke/.config/awesome/icons/bat.png"
theme.widget_mem    = "/home/luke/.config/awesome/icons/mem.png"
theme.widget_fs     = "/home/luke/.config/awesome/icons/disk.png"
theme.widget_net    = "/home/luke/.config/awesome/icons/down.png"
theme.widget_netup  = "/home/luke/.config/awesome/icons/up.png"
theme.widget_wifi   = "/home/luke/.config/awesome/icons/wifi.png"
theme.widget_mail   = "/home/luke/.config/awesome/icons/mail.png"
theme.widget_vol    = "/home/luke/.config/awesome/icons/vol.png"
theme.widget_org    = "/home/luke/.config/awesome/icons/cal.png"
theme.widget_date   = "/home/luke/.config/awesome/icons/time.png"
theme.widget_crypto = "/home/luke/.config/awesome/icons/crypto.png"
theme.widget_sep    = "/home/luke/.config/awesome/icons/separator.png"
-- }}}

-- {{{ Titlebar icons
theme.titlebar_close_button_focus  = "/home/luke/.config/awesome/icons/titlebar/close_focus.png"
theme.titlebar_close_button_normal = "/home/luke/.config/awesome/icons/titlebar/close_normal.png"

theme.titlebar_ontop_button_focus_active    = "/home/luke/.config/awesome/icons/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active   = "/home/luke/.config/awesome/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = "/home/luke/.config/awesome/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = "/home/luke/.config/awesome/icons/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active    = "/home/luke/.config/awesome/icons/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active   = "/home/luke/.config/awesome/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = "/home/luke/.config/awesome/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = "/home/luke/.config/awesome/icons/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active    = "/home/luke/.config/awesome/icons/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active   = "/home/luke/.config/awesome/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = "/home/luke/.config/awesome/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = "/home/luke/.config/awesome/icons/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active    = "/home/luke/.config/awesome/icons/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = "/home/luke/.config/awesome/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = "/home/luke/.config/awesome/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = "/home/luke/.config/awesome/icons/titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}

return theme
