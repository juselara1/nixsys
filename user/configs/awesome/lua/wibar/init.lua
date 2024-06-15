local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local function setup(_)
	local buttons = gears.table.join(
	awful.button({ }, 1, function(t) t:view_only() end)
	)

	awful.screen.connect_for_each_screen(function(s)
		s.mytaglist = awful.widget.taglist {
			screen = s,
			filter = awful.widget.taglist.filter.all,
			style = {
				shape = gears.shape.rounded_rect
			},
			buttons = buttons,
			layout = {
				spacing = 10,
				spacing_widget = {
					widget = wibox.layout.separator
				},
				layout = wibox.layout.fixed.horizontal
			}
		}
		s.mywibox = awful.wibar{position = "top", screen = s, height=30}
		s.mywibox.bg = beautiful.border_normal
		s.mywibox.fg = beautiful.fg
		s.mywibox.opacity = beautiful.opacity
		s.mywibox:setup {
			layout = wibox.layout.align.horizontal,
			expand = "none",
			-- left
			wibox.widget.textbox(""),
			-- center
			wibox.widget{
				align = "center",
				valign = "center",
				widget = s.mytaglist
			},
			-- right
			wibox.widget.textbox("")
		}
	end)
end

return {
	setup = setup
}
