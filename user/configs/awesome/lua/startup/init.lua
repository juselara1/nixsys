local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
require("awful.autofocus")

---Setups the client startup
---@param args {client: {connect_signal: function}, awesome: {startup: boolean}}
local function setup(args)
	-- Define layout
	awful.layout.layouts = {
		awful.layout.suit.tile,
		-- awful.layout.suit.max.fullscreen
	}
	-- Creates workspaces
	awful.screen.connect_for_each_screen(function(s)
		awful.tag.add("Normal", {
			layout = awful.layout.layouts[1],
			screen = s,
			selected = true
		})
		awful.tag.add("Background", {
			layout = awful.layout.layouts[1],
			screen = s
		})
	end)

	-- Defines what happens when a client connects
	args.client.connect_signal("manage", function (c)
		c.shape = function(cr, w, h)
			gears.shape.rounded_rect(cr, w, h, 10)
		end

		if args.awesome.startup
			and not c.size_hints.user_position
			and not c.size_hints.program_position then
			awful.placement.no_offscreen(c)
		end
	end)
	args.client.connect_signal("focus", function(c)
		c.border_color = beautiful.border_focus
	end)
	args.client.connect_signal("unfocus", function(c)
		c.border_color = beautiful.border_normal
	end)

	args.client.connect_signal("mouse::enter", function(c)
		c:emit_signal("request::activate", "mouse_enter", {raise = false})
	end)
end

return {
	setup = setup
}
