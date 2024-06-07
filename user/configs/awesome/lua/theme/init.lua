---Setups theme
local function setup(_)
	local beautiful = require("beautiful")
	beautiful.menu_font = "UbuntuMono 15"
	beautiful.menu_height = 30
	beautiful.menu_width = 200
	beautiful.menu_bg_normal = "#111111"
	beautiful.menu_bg_focus = "#222222"
	beautiful.menu_fg_normal = "#689D6A"
	beautiful.menu_fg_focus = "#689D6A"
	beautiful.border_width = 3
	beautiful.border_normal = "#111111"
	beautiful.border_focus = "#689D6A"
	beautiful.useless_gap = 5
end

return {
	setup = setup
}
