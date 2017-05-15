-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local vicious = require("vicious")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local io = io
-- Initialize widget
datewidget = wibox.widget.textbox()
-- Register widget
vicious.register(datewidget, vicious.widgets.date, "%a, %b %d, %T", 1)

-- {{{ Battery state
-- Initialize widget
-- batwidget = awful.widget.progressbar()
--batwidget:set_width(8)
--batwidget:set_height(14)
--batwidget:set_vertical(true)
--batwidget:set_background_color("#000000")
--batwidget:set_border_color(nil)
--batwidget:set_color("#00ff00")

-- {{{ Battery state
-- Initialize widget
--vicious.register(batwidget, vicious.widgets.bat, "$2", 120, "BAT0")

--healthwidget = wibox.widget.textbox()
--vicious.register(healthwidget, vicious.widgets.health, "", 30)
-- Initialize widget
memwidget = wibox.widget.textbox()
-- Register widget
vicious.register(memwidget, vicious.widgets.mem, "$1% ($2MB/$3MB)", 13)
-- Initialize widget
memwidget = awful.widget.progressbar()
-- Progressbar properties
memwidget:set_width(8)
memwidget:set_height(10)
memwidget:set_vertical(true)
memwidget:set_background_color("#494B4F")
memwidget:set_border_color(nil)
memwidget:set_color({ type = "linear", from = { 0, 0 }, to = { 100,0 }, stops = { {0, "#AECF96"}, {0.5, "#88A175"}, {1, "#FF5656"}}})
-- Register widget
vicious.register(memwidget, vicious.widgets.mem, "$1", 1)
-- Initialize widget
cputextwidget = wibox.widget.textbox()
-- Register widget
vicious.register(cputextwidget, vicious.widgets.cpu, "CPU: $1%", 1)
local cpulayout = wibox.layout.constraint()
cpulayout:set_widget(cputextwidget)
cpulayout:set_strategy('exact')
cpulayout:set_width(60)

-- Initialize widget
cpuwidget = awful.widget.progressbar()
-- Graph properties
cpuwidget:set_width(8)
cpuwidget:set_height(10)
cpuwidget:set_max_value(100)
cpuwidget:set_vertical(true)
cpuwidget:set_background_color("#494B4F")
cpuwidget:set_border_color(nil)
cpuwidget:set_color({ type = "linear", from = { 0, 0 }, to = { 100,0 }, stops = { {0, "#AECF96"}, {0.5, "#88A175"}, {1, "#FF5656"}}})

--cpuwidget:set_color({ type = "linear", from = { 0, 0 }, to = { 100,0 }, stops = { {0, "#FF5656"}, {0.5, "#88A175"}, {1, "#AECF96" }}})
-- Register widget
vicious.register(cpuwidget, vicious.widgets.cpu, "$1", 1)
cpufreqwidget = wibox.widget.textbox()
-- Graph properties
-- Register widget
--vicious.register(cpufreqwidget, vicious.widgets.cpufreq, "", 1)


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
beautiful.init("/home/rains/.config/awesome/themes/rains/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "terminator"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor
-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.max,
    awful.layout.suit.floating,
    --awful.layout.suit.tile,
    --awful.layout.suit.tile.left,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.magnifier,
    awful.layout.suit.max.fullscreen,
}
-- }}}

--- {{{ Wallpaper
local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
    { "arandr", "arandr" },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", "geany" .. " " .. awesome.conffile },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end }
}
require("menu")
local xmenu = xdgmenu
table.insert(xmenu, 1, {"awesome",myawesomemenu})
mymainmenu = awful.menu(xmenu)
mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = awful.util.table.join(
awful.button({ }, 1, function(t) t:view_only() end),
awful.button({ modkey }, 1, function(t)
    if client.focus then
        client.focus:movetotag(t)
    end
end),
awful.button({ }, 3, awful.tag.viewtoggle),
awful.button({ modkey }, 3, function(t)
    if client.focus then
        client.focus.toggle_tag(t)
    end
end),
awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)
local tasklist_buttons = awful.util.table.join(
awful.button({ }, 1, function (c)
    if c == client.focus then
        c.minimized = true
    else
        -- Without this, the following
        -- :isvisible() makes no sense
        c.minimized = false
        if not c:isvisible() and c.first_tag then
            c.first_tag:viewonly()
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

--for s = 1, screen.count() do
awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
    awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
    awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
    awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibox({ position = "top", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(s.mytaglist)
    left_layout:add(s.mypromptbox)

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    local systray = wibox.widget.systray()
    --right_layout:add(mytextclock)
    right_layout:add(systray)
    right_layout:add(memwidget)
    -- right_layout:add(batwidget)
    right_layout:add(cpuwidget)
    right_layout:add(cpulayout)
    right_layout:add(datewidget)
    right_layout:add(s.mylayoutbox)
    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(s.mytasklist)
    layout:set_right(right_layout)
    s.mywibox:set_widget(layout)
end)
-- }}}

-- {{{ Mouse bindings
--root.buttons(awful.util.table.join(
--    awful.button({ }, 3, function () mymainmenu:toggle() end),
--    awful.button({ }, 4, awful.tag.viewnext),
--    awful.button({ }, 5, awful.tag.viewprev)
--))
-- }}}
--local rstat = -1
--local rotate = function() 
--    rstat = (rstat + 1) % 4 
--    return rstat
--end
-- {{{ Key bindings
globalkeys = awful.util.table.join(
awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
awful.key({ modkey,           }, "Up",     awful.tag.viewprev       ),
awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
awful.key({ modkey,           }, "Down",   awful.tag.viewnext       ),
awful.key({ modkey,           }, "Escape", awful.tag.history.restore),
awful.key({ "Control"         }, "Tab", function ()
    awful.client.focus.byidx(1)
    if client.focus then client.focus:raise() end
end),
awful.key({ "Control", "Shift"}, "Tab", function ()
    awful.client.focus.byidx(-1)
    if client.focus then client.focus:raise() end
end),

awful.key({ modkey, "Control" }, "Left",
function ()
    awful.client.focus.byidx( -1)
    if client.focus then client.focus:raise() end
end),
awful.key({ modkey, "Control" }, "Right",
function ()
    awful.client.focus.byidx(1)
    if client.focus then client.focus:raise() end
end),
awful.key({ modkey,           }, "j",
function ()
    awful.client.focus.byidx( 1)
    if client.focus then client.focus:raise() end
end),
awful.key({ modkey,           }, "k",
function ()
    awful.client.focus.byidx(-1)
    if client.focus then client.focus:raise() end
end),
awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

-- Layout manipulation
awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
awful.key({ modkey,           }, "Tab",
function ()
    awful.client.focus.history.previous()
    if client.focus then
        client.focus:raise()
    end
end),

-- Standard program
awful.key({ modkey,           }, "Return", function () 
    awful.spawn(terminal) 
    if client.focus then client.focus:raise() end
end),
awful.key({ modkey, "Control" }, "r", awesome.restart),
awful.key({ modkey, "Shift"   }, "q", awesome.quit),
awful.key({ modkey, "Shift"   }, "p", function () awful.spawn("/home/rains/.screenlayout/1080x1920.sh")  end),
awful.key({ modkey            }, "p", function () awful.spawn("/home/rains/.screenlayout/1920x1080.sh")  end),
awful.key({ modkey,           }, "l",     function () awful.spawn("slock")     end),
awful.key({ modkey,           }, "c",     function () awful.spawn("pass -c knownsec")     end),
awful.key({ "Control","Mod1"   }, "Down",     function () awful.spawn("xrandr -o 0")     end),
awful.key({ "Control","Mod1"   }, "Left",     function () awful.spawn("xrandr -o 1")     end),
awful.key({ "Control","Mod1"   }, "Up",     function () awful.spawn("xrandr -o 2")     end),
awful.key({ "Control","Mod1"   }, "Right",     function () awful.spawn("xrandr -o 3")     end),
awful.key({ modkey,            }, "Print", function () awful.spawn("xfce4-screenshooter")     end),
--    awful.key({                   }, "XF86Launch1", function () awful.spawn("terminator -e up")     end),
awful.key({                   }, "XF86Display", function () awful.spawn("disper --cycle-stages='-s : -e : -c : -S' --cycle")     end),
awful.key({                   }, "XF86RotateWindows", function () awful.spawn("env DISPLAY=:0 /usr/bin/thinkpad-rotate")     end),
awful.key({                   }, "XF86TaskPane", function ()  awful.spawn("sudo pm-suspend")   end),
--awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
--awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

awful.key({ modkey, "Control" }, "n", awful.client.restore),

-- Prompt
awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run()     end),
-- Menubar
awful.key({ "Mod1" }, "r", function () awful.spawn("kupfer")     end),

awful.key({ modkey }, "x", function ()
    awful.prompt.run {
        prompt          = "Run Lua code: ",
        textbox         = awful.screen.focused().mypromptbox.widget,
        exe_callback    = awful.util.eval,
        history_path    = awful.util.get_cache_dir() .. "/history_eval"
    }
end)
)
clientkeys = awful.util.table.join(
awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
--awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
awful.key({ "Mod1"            }, "F4",     function (c) c:kill()                         end),
awful.key({ "Mod1"            }, "q",      function (c) c:kill()                         end),
awful.key({ modkey, "Control" }, "f",      awful.client.floating.toggle                     ),
awful.key({ modkey, "Control" }, "t",      awful.titlebar.toggle                     ),
awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
awful.key({ modkey,           }, "o",      function (c) c:move_to_screen() end),
awful.key({ modkey,           }, "s",      function (c,s) 
    local sel = c or client                         
    if sel then
        awful.client.focus.byidx(-1)
        local sc = screen.count()
        if not s then
            s = sel.screen + 1 
        end
        if s > sc then s = 1 elseif s < 1 then s = sc end 
        sel.screen = s 
    end
end),
awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
awful.key({ modkey,           }, "n",
function (c)
    -- The client currently has the input focus, so it cannot be
    -- minimized, since minimized clients can't have the focus.
    c.minimized = true
end),
awful.key({ modkey,           }, "m",
function (c)
    if type(c.maximized_horizontal) == nil or type(c.maximized_vertical) == nil then
        c.maximized_horizontal = true
        c.maximized_vertical = true
    end
    --c.maximized_horizontal = not c.maximized_horizontal
    --c.maximized_vertical   = not c.maximized_vertical
end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 0 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
    awful.key({ modkey }, "#" .. i + 9,
    function ()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
            tag:view_only()
        end
    end),
    -- Toggle tag display
    awful.key({ modkey, "Control" }, "#" .. i + 9,
    function ()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
            awful.tag.viewtoggle(tag)
        end
    end),
    awful.key({ modkey, "Shift" }, "#" .. i + 9,
    function ()
        local tag = client.focus.screen.tags[i]
        if tag then
            client.focus:move_to_tag(tag)
        end
    end),
    -- Toggle tag on focused client
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
    function ()
        local tag = client.focus.screen.tags[i]
        if client.focus and tag then
            client.focus:toggle_tag(tag)
        end
    end)
    )
end

clientbuttons = awful.util.table.join(
awful.button({ }, 1, function (c) 
    if c.class ~= "Onboard" then
        client.focus = c; c:raise() 
    end
end),
awful.button({ modkey }, 1, awful.mouse.client.move),
awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { 
        rule = { },
        properties = { 
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    },
    { 
        rule = { class = "Conky" },
        properties = { floating = true }
    },
    { 
        rule = { class = "MPlayer" },
        properties = { floating = true } 
    },
    {
        rule = { class = "pinentry" },
        properties = { floating = true }
    },
    { 
        rule = { class = "gimp" },
        properties = { floating = true } 
    },
    {
        rule = { class = "Pidgin" },
        properties = { floating = true } 
    },
    { 
        rule = { class = "dia" },
        properties = { floating = true}
    },
    { 
        rule = { class = "Skype" },
        properties = { floating = true, titlebars_enabled = true} 
    },
    {
        rule = { class = "Vmware" },
        properties = { screen = 1, tag = "2" } 
    },
    -- Set Firefox to always map on tags number 2 of screen 1.
    --{ rule = { class = "Firefox" },
    --  properties = { tag = tags[1][2],floating = false } },
    --{ rule = { class = "chrome" },
    --  properties = { tag = tags[1][3],floating = false } },
    --{ rule = { class = "Terminator" },
    --  properties = { tag = tags[1][4],floating = false } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) 
            and c.class ~= "Onboard" then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    --local titlebars_enabled = false
    local titlebars_enabled = true
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
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
        )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        --right_layout:add(awful.titlebar.widget.stickybutton(c))
        --right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
        awful.titlebar.hide(c)
    end
end)

client.connect_signal("focus", function(c) 
    c.border_color = beautiful.border_focus 
    c.opacity = 1.0
end)
client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal 
    c.opacity = 1.0 
end)
-- }}}
-- configuration - edit to your liking
wp_index = 1
wp_timeout  = 60
wp_path = "/home/rains/.config/awesome/themes/rains/wallpapers/"
wp_files = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9}

-- setup the timer
wp_timer = timer { timeout = wp_timeout }
wp_timer:connect_signal("timeout", function()

    -- set wallpaper to current index for all screens
    for s = 1, screen.count() do
        gears.wallpaper.maximized(wp_path .. wp_files[wp_index] .. ".jpg", s, true)
    end

    -- stop the timer (we don't need multiple instances running at the same time)
    wp_timer:stop()

    -- get next random index
    wp_index = math.random( 1, #wp_files)

    --restart the timer
    wp_timer.timeout = wp_timeout
    wp_timer:start()
end)

-- initial start when rc.lua is first run
--wp_timer:start()
require("autostart")

run_once_list({
    "source ~/.zshrc.env",
    "xmodmap /home/rains/.xmodmaprc",
    "run_once vmware-tray",
    "nixnote",
    "run_once wicd-gtk",
    "xcompmgr -c",
    "setxkbmap","tilda","kupfer",
    "cryptkeeper",
    "mate-power-manager",
    "volumeicon",
    "clipit",
    --"orage",
    --"conky",
    --"run_once udiskie -a -n -t -f Thunar",
    "/home/rains/.screenlayout/1920x1080.sh",
    "/usr/local/bin/autorandr.sh",
    --"xfce4-notes",
    "youdao-dict",
    "dropbox",
    --"/usr/share/magick-rotation/magick-rotation",
    --"pcmanfm --desktop --one-screen",
    "conky",
    --"nm-applet",
    "geeteedee",
})


--
-- Use the second argument, if the programm you wanna start, 
-- differs from the what you want to search.
--run_once("redshift", "nice -n19 redshift -l 51:14 -t 5700:4500")
--run_once 


