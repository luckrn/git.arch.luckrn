----------------------------------------------------------------
-- Drop-down applications manager for the awesome window manager
----------------------------------------------------------------
-- Adrian C. <anrxc.sysphere.org>
-- Licensed under the WTFPL version 2
--   * http://sam.zoy.org/wtfpl/COPYING
----------------------------------------------------------------
-- To use this module add:
--   require("teardrop")
-- to the top of your rc.lua, and call it from a keybinding:
--   teardrop(prog, pos, edge, height, width, sticky, screen)
--
-- Parameters:
--   prog   - Program to run; "urxvt", "gmrun", "thunderbird"
--   vert   - Vertical; "bottom", "center" or "top" (default)
--   horiz  - Horizontal; "left", "right" or "center" (default)
--   width  - Width in absolute pixels, or width percentage
--            when < 1 (0.9999 (99.9% of the screen) default)
--   height - Height in absolute pixels, or height percentage
--            when < 1 (0.25 (25% of the screen) default)
--   sticky - Visible on all tags, false by default
--   screen - Screen (optional), mouse.screen by default
----------------------------------------------------------------

-- Grab environment
local pairs = pairs
local awful = require("awful")
local setmetatable = setmetatable
local capi = {
    mouse = mouse,
    client = client,
    screen = screen
}

-- Teardrop: Drop-down applications manager for the awesome window manager
module("teardrop")

local dropdown = {}

-- Create a new window for the drop-down application when it doesn't
-- exist, or toggle between hidden and visible states when it does
function toggle(prog, vert, horiz, width, height, sticky, screen)
    local vert   = vert   or "top"
    local horiz  = horiz  or "center"
    local width  = width  or 0.9999
    local height = height or 0.25
    local sticky = sticky or false
    local screen = screen or capi.mouse.screen

    if not dropdown[prog] then
        dropdown[prog] = {}

        -- Add unmanage signal for teardrop programs
        capi.client.add_signal("unmanage", function (c)
            for scr, cl in pairs(dropdown[prog]) do
                if cl == c then
                    dropdown[prog][scr] = nil
                end
            end
        end)
    end

    if not dropdown[prog][screen] then
        spawnw = function (c)
            dropdown[prog][screen] = c

            -- Teardrop clients are floaters
            awful.client.floating.set(c, true)

            -- Client geometry and placement
            local screengeom = capi.screen[screen].workarea

            if width  < 1 then width  = screengeom.width  * width  end
            if height < 1 then height = screengeom.height * height end

            if     horiz == "left"  then x = screengeom.x
            elseif horiz == "right" then x = screengeom.width - width
            else   x =  screengeom.x+(screengeom.width-width)/2 end

            if     vert == "bottom" then y = screengeom.height + screengeom.y - height
            elseif vert == "center" then y = screengeom.y+(screengeom.height-height)/2
            else   y =  screengeom.y - screengeom.y end

            -- Client properties
            c:geometry({ x = x, y = y, width = width, height = height })
            c.ontop = true
            c.above = true
            c.skip_taskbar = true
            if sticky then c.sticky = true end
            if c.titlebar then awful.titlebar.remove(c) end

            c:raise()
            capi.client.focus = c
            capi.client.remove_signal("manage", spawnw)
        end

        -- Add manage signal and spawn the program
        capi.client.add_signal("manage", spawnw)
        awful.util.spawn(prog, false)
    else
        -- Get a running client
        c = dropdown[prog][screen]

        -- Switch the client to the current workspace
        if c:isvisible() == false then c.hidden = true;
            awful.client.movetotag(awful.tag.selected(screen), c)
        end

        -- Focus and raise if hidden
        if c.hidden then
            -- Make sure it is centered
            if vert  == "center" then awful.placement.center_vertical(c)   end
            if horiz == "center" then awful.placement.center_horizontal(c) end
            c.hidden = false
            c:raise()
            capi.client.focus = c
        else -- Hide and detach tags if not
            c.hidden = true
            local ctags = c:tags()
            for i, v in pairs(ctags) do
                ctags[i] = nil
            end
            c:tags(ctags)
        end
    end
end

setmetatable(_M, { __call = function(_, ...) return toggle(...) end })