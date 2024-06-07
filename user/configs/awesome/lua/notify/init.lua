local naughty = require("naughty")

local function setup(args)
	if args.awesome.startup_errors then
		naughty.notify {
            preset = naughty.config.presets.critical,
            title = "Startup error found.",
            text = args.awesome.startup_errors,
        }
	end

	-- Handle runtime errors after startup
	do
		local in_error = false
		args.awesome.connect_signal("debug::error", function (err)
			-- Make sure we don't go into an endless error loop
			if in_error then return end
			in_error = true

			naughty.notify {
                preset = naughty.config.presets.critical,
                title = "Error found.",
                text = tostring(err),
            }
			in_error = false
		end)
	end
end

return {
	setup = setup
}
