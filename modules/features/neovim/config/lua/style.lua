local M = {}

---@class StyleConfig # Style configuration for a programming language.
---@field pattern string[] # Pattern to detect the filetypes.
---@field num_spaces integer # Number of spaces for indentation.
---@field expandtab boolean? # Use spaces instead of tabs.
---@field textwidth integer? # Maximum width of a line.
---@field colorcolumn integer? # Visual vertical line at specific column.

---Setups style for a programming language.
---@param config StyleConfig # Style configuration.
local function setup_style(config)
	vim.o.shiftwidth = config.num_spaces
	vim.o.tabstop = config.num_spaces
	vim.o.softtabstop = config.num_spaces

	if config.expandtab ~= nil then
		vim.o.expandtab = config.expandtab
	end

	if config.textwidth ~= nil then
		vim.o.textwidth = config.textwidth
	end

	if config.colorcolumn ~= nil then
		vim.o.colorcolumn = tostring(config.colorcolumn)
	end
end

---Setups the autocommand for a given programming language.
---@param config StyleConfig # Style configuration.
---@param group any
local function setup_style_autocmd(config, group)
	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
		group = group,
		desc = "Sets the styling.",
		pattern = config.pattern,
		callback = function(_)
			setup_style(config)
		end,
	})
end

---Setup function
---@param configs table<string, StyleConfig> # Map of language names to their style configurations.
function M.setup(configs)
	local group = vim.api.nvim_create_augroup("CodeStyle", {})
	for _, config in pairs(configs) do
		setup_style_autocmd(config, group)
	end
end

return M
