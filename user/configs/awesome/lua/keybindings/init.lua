local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")

---Setups mouse bindings
local function set_client_keys(args)
	local clientbuttons = gears.table.join(
		awful.button({ }, 1, function (c)
			c:emit_signal("request::activate", "mouse_click", {raise = true})
		end),
		awful.button({ "Mod4" }, 1, function (c)
			c:emit_signal("request::activate", "mouse_click", {raise = true})
			awful.mouse.client.move(c)
		end),
		awful.button({ "Mod4" }, 3, function (c)
			c:emit_signal("request::activate", "mouse_click", {raise = true})
			awful.mouse.client.resize(c)
		end)
	)

	local clientkeys = gears.table.join(
		awful.key({ "Mod4" }, "f", function (c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end, {description = "Toggle fullscreen", group = "client"}),
		awful.key({ "Mod4" }, "q", function (c)
			c:kill()
		end, {description = "Close client", group = "client"}),
		awful.key({ "Mod4" }, "p", function (_)
			awful.client.floating.toggle()
		end, {description = "Toggle floating", group = "client"}),
		awful.key({ "Mod4", "Shift" }, "h", function (c)
			c:move_to_screen(c.screen.index + 1)
		end, {description = "Move to left screen", group = "client"}),
		awful.key({ "Mod4", "Shift" }, "l", function (c)
			c:move_to_screen(c.screen.index - 1)
		end, {description = "Move to right", group = "client"}),
		awful.key({ "Mod4" }, "t", function (c)
			c.ontop = not c.ontop
		end, {description = "Move to top of screen", group = "client"}),
		awful.key({ "Mod4", }, "m", function (c)
			c:swap(awful.client.getmaster())
		end, {description = "Move to master", group = "client"})
	)

	awful.rules.rules = {
		{
			rule = { },
			properties = {
				border_width = beautiful.border_width,
				border_color = beautiful.border_normal,
				focus = awful.client.focus.filter,
				raise = true,
				keys = clientkeys,
				buttons = clientbuttons,
				screen = awful.screen.preferred,
				placement = awful.placement.no_overlap + awful.placement.no_offscreen
			}
		}
	}
	args.client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
	args.client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
end

---Setups global keys
---@param args {terminal: string, root: {keys: function, buttons: function}, awesome: {quit: function, restart: function}, client: {focus: boolean, focus: {first_tag: table, move_to_tag: function}}}
local function set_global_keys(args)
	local globalkeys = gears.table.join(
		awful.key({"Mod4"}, "Return", function()
			awful.spawn(args.terminal)
		end, {description="Open terminal", group="launcher"} ),
		awful.key(
            {"Mod4", "Control"}, 'q', function()
				args.awesome.quit()
			end, {description="Quit awesome", group="awesome"}
        ),
		awful.key(
            {"Mod4", "Control"}, 'r', function()
				args.awesome.restart()
			end, {description="Quit awesome", group="awesome"}
        ),
		awful.key(
			{"Mod4"}, 'j', function()
				awful.client.focus.byidx(1)
			end, {description="Focus next client", group="client"}
		),
		awful.key(
			{"Mod4"}, 'k', function()
				awful.client.focus.byidx(-1)
			end, {description="Focus previous client", group="client"}
		),
		awful.key(
			{"Mod4"}, 'h', function()
				awful.screen.focus_relative(1)
			end, {description="Focus next screen", group="client"}
		),
		awful.key(
			{"Mod4"}, 'l', function()
				awful.screen.focus_relative(-1)
			end, {description="Focus previous screen", group="client"}
		),
		awful.key(
			{"Mod4"}, "b", function()
				local screen = awful.screen.focused()
				local active_tag = awful.screen.focused().selected_tag
				for _, tag in ipairs(screen.tags) do
					if active_tag ~= tag then
						tag:view_only()
					end
				end
			end, {description="See background", group="client"}
		),
		awful.key(
			{"Mod4", "Shift"}, "b", function()
				local screen = awful.screen.focused()
				local active_tag = awful.screen.focused().selected_tag
				if active_tag == screen.tags[2] then
					args.client.focus:move_to_tag(screen.tags[1])
					screen.tags[1]:view_only()
				elseif active_tag == screen.tags[1] then
					args.client.focus:move_to_tag(screen.tags[2])
				end
			end, {description="See background", group="client"}
		)
	)

	local mousekeys = gears.table.join(
		awful.button({ }, 4, awful.tag.viewnext),
		awful.button({ }, 5, awful.tag.viewprev)
	)

	args.root.buttons(mousekeys)
	args.root.keys(globalkeys)
end

local function setup(args)
	local terminal = "alacritty"
	set_global_keys({terminal=terminal, root=args.root, awesome=args.awesome, client=args.client})
	set_client_keys({client=args.client})
end

return {
	setup = setup
}
