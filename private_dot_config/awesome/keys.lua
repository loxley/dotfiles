local gears = require'gears'
local awful = require'awful'
local beautiful = require'beautiful'
local bling = require("bling")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

modkey = "Mod4"
altkey = "Mod1"

launcher = "rofi -normal-window -show drun -modi drun,ssh -theme ~/.config/awesome/rofi.rasi"
screenshot = "flameshot screen -p '/home/loxley/Pictures/screenshots/'"
screenshot_selection = "flameshot gui -d 1000"

-- Mouse bindings
root.buttons(gears.table.join(
    --awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

local term_scratch = bling.module.scratchpad {
    command = "alacritty --class scratchpad --title scratchpad -e nvim -c 'startinsert' /tmp/scratchpad.md", -- How to spawn the scratchpad
    rule = { instance = "scratchpad" },               -- The rule that the scratchpad will be searched by
    sticky = true,                                    -- Whether the scratchpad should be sticky
    autoclose = true,                                 -- Whether it should hide itself when losing focus
    floating = true,                                  -- Whether it should be floating (MUST BE TRUE FOR ANIMATIONS)
    geometry = {x=360, y=90, height=900, width=1200}, -- The geometry in a floating state
    reapply = false,                                  -- Whether all those properties should be reapplied on every new opening of the scratchpad (MUST BE TRUE FOR ANIMATIONS)
    dont_focus_before_close  = false,                 -- When set to true, the scratchpad will be closed by the toggle function regardless of whether its focused or not. When set to false, the toggle function will first bring the scratchpad into focus and only close it on a second call
    rubato = {x = anim_x, y = anim_y}                 -- Optional. This is how you can pass in the rubato tables for animations. If you don't want animations, you can ignore this option.
}

-- Globals
local globalkeys = gears.table.join(
    
    -- Group: Awesome
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "s", function ()
        awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible
        end, {description = "Toggle systray visibility", group = "awesome"}),
    awful.key({ modkey,           }, "s", hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    
    -- Group: Screen
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    
    -- Group: Tag
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),
    
    -- Group: Client
    awful.key({ modkey,           }, "j",
              function ()
                  awful.client.focus.byidx(1)
                  bling.module.flash_focus.flashfocus(client.focus)
              end,
              {description = "focus next by index", group = "client"}),
    awful.key({ modkey,           }, "k",
              function ()
                  awful.client.focus.byidx(-1)
                  bling.module.flash_focus.flashfocus(client.focus)
              end,
              {description = "focus previous by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "j",
              function ()
                  awful.client.swap.byidx(  1)
                  bling.module.flash_focus.flashfocus(client.focus)
              end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k",
              function ()
                  awful.client.swap.byidx( -1)
                  bling.module.flash_focus.flashfocus(client.focus)
              end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),
    
    -- Group: Layout
    awful.key({ modkey,           }, "b",
        function ()
            myscreen = awful.screen.focused()
            myscreen.wibox.visible = not myscreen.wibox.visible
        end,
        {description = "toggle statusbar", group = "layout"}),
    awful.key({ modkey,           }, "l", function () awful.tag.incmwfact( 0.05)                   end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h", function () awful.tag.incmwfact(-0.05)                   end,
              {descrition = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h", function () awful.tag.incnmaster( 1, nil, true)          end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l", function () awful.tag.incnmaster(-1, nil, true)          end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h", function () awful.tag.incncol( 1, nil, true)             end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l", function () awful.tag.incncol(-1, nil, true)             end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "c", function () awful.layout.set(bling.layout.centered)      end,
              {description = "centered mode (bling)", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "f", function () awful.layout.set(awful.layout.suit.floating) end,
              {description = "floating mode", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "t", function () awful.layout.set(awful.layout.suit.tile)     end,
              {description = "tiling mode", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "e", function () awful.layout.set(bling.layout.equalarea)     end,
              {description = "equalarea mode (bling)", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "x", function () awful.layout.set(awful.layout.suit.max)      end,
              {description = "monocle (max) mode", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "b", function () awful.layout.set(awful.layout.suit.tile.bottom) end,
              {description = "tiling mode (bottom)", group = "layout"}),

    -- Group: Launcher
    awful.key({ modkey,           }, "p", function () term_scratch:toggle()         end,
              {description = "scratchpad", group = "launcher"}),
    awful.key({ modkey,           }, "Return", function () awful.spawn("alacritty") end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey,           }, "d",      function () awful.spawn(launcher)    end,
              {description = "application launcher", group = "launcher"}),
    awful.key({ modkey,           }, "w",      function () awful.spawn("brave")     end,
              {description = "browser", group = "launcher"}),
    awful.key({ modkey,           }, "e",      function () awful.spawn("thunar")    end,
              {description = "file manager", group = "launcher"}),
    awful.key({ modkey,           }, "0",      function () awful.spawn("light-locker-command -l")    end,
              {description = "lock screen", group = "launcher"}),
    awful.key({                   }, "Print",
        function ()
            awful.util.spawn_with_shell(screenshot_selection)
        end,
        {description = "take screenshot selection", group = "launcher"}),
    awful.key({ "Shift",          }, "Print",
        function ()
            awful.util.spawn(screenshot, false)
        end,
        {description = "take screenshot", group = "launcher"}),

    awful.key({ }, "XF86MonBrightnessUp",   function () awful.util.spawn("xbacklight -inc 10") end),
    awful.key({ }, "XF86MonBrightnessDown", function () awful.util.spawn("xbacklight -dec 10") end),

    awful.key({ }, "XF86AudioRaiseVolume",  function () awful.util.spawn("pamixer -i 5") end),
    awful.key({ }, "XF86AudioLowerVolume",  function () awful.util.spawn("pamixer -d 5") end),
    awful.key({ }, "XF86AudioMute",         function () awful.util.spawn("pamixer -t") end),

    awful.key({ }, "XF86AudioPlay",         function()  awful.util.spawn("playerctl play-pause", false) end),
    awful.key({ }, "XF86AudioNext",         function()  awful.util.spawn("playerctl next", false) end),
    awful.key({ }, "XF86AudioPrev",         function()  awful.util.spawn("playerctl previous", false) end),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () client.connect_signal("focus", function(c)
                              c.border_color = beautiful.border_focus
                              c.opacity = 1
                           end) end,
              {description = "opacity = 1", group = "launcher"}),
    awful.key({ modkey, "Shift"},            "r",     function () client.connect_signal("focus", function(c)
                              c.border_color = beautiful.border_focus
                              c.opacity = 0.9
                           end) end,
              {description = "opacity = 0.9", group = "launcher"})
)

awful.util.taglist_buttons = awful.util.table.join(awful.button({}, 1, function(t)
	t:view_only()
end), awful.button({modkey}, 1, function(t)
	if client.focus then
		client.focus:move_to_tag(t)
	end
end), awful.button({}, 3, awful.tag.viewtoggle), awful.button({modkey}, 3, function(t)
	if client.focus then
		client.focus:toggle_tag(t)
	end
end), awful.button({}, 5, function(t)
	awful.tag.viewnext(t.screen)
end), awful.button({}, 4, function(t)
	awful.tag.viewprev(t.screen)
end))

-- Tags
for i = 1, 9 do
  globalkeys = gears.table.join(globalkeys,
    -- View tag only.
    awful.key({ modkey }, "#" .. i + 9,
              function ()
                    local screen = awful.screen.focused()
                    local tag = screen.tags[i]
                    if tag then
                       tag:view_only()
                    end
              end,
              {description = "view tag #"..i, group = "tag"}),
    -- Toggle tag display.
    awful.key({ modkey, "Control" }, "#" .. i + 9,
              function ()
                  local screen = awful.screen.focused()
                  local tag = screen.tags[i]
                  if tag then
                     awful.tag.viewtoggle(tag)
                  end
              end,
              {description = "toggle tag #" .. i, group = "tag"}),
    -- Move client to tag.
    awful.key({ modkey, "Shift" }, "#" .. i + 9,
              function ()
                  if client.focus then
                      local tag = client.focus.screen.tags[i]
                      if tag then
                          client.focus:move_to_tag(tag)
                      end
                 end
              end,
              {description = "move focused client to tag #"..i, group = "tag"}),
    -- Toggle tag on focused client.
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
              function ()
                  if client.focus then
                      local tag = client.focus.screen.tags[i]
                      if tag then
                          client.focus:toggle_tag(tag)
                      end
                  end
              end,
              {description = "toggle focused client on tag #" .. i, group = "tag"})
  )
end

root.keys(globalkeys)
