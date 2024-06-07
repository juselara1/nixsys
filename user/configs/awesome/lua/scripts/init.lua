local function setup(_)
	local awful = require("awful")
	awful.spawn.with_shell("picom")
	awful.spawn.with_shell(os.getenv("HOME").."/.config/home-manager/configs/wallpaper.sh")
end

return {
	setup = setup
}
