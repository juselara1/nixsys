local theme_assets = require("beautiful.theme_assets")

---Setups theme
local function setup(_)
	local beautiful = require("beautiful")
	beautiful.font = "UbuntuMono 12"
	beautiful.fg = "#D5C4A1"
	beautiful.bg = "#282828"
	beautiful.opacity = 0.85
	beautiful.focus = "#689D6A"
	beautiful.border_width = 3
	beautiful.border_normal = beautiful.bg
	beautiful.border_focus = beautiful.focus
	beautiful.useless_gap = 5
	beautiful.taglist_squares_sel = theme_assets.taglist_squares_sel(
        150,
        beautiful.focus
    )
	beautiful.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
		150, beautiful.bg
	)
end

return {
	setup = setup
}
