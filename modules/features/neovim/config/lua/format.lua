---@class Formatter
---@field executable string # Executable command to validate
---@field cmd_fn fun(filename: string): string # Creates command to execute based on the filename.

---@class FormatConfig # Language specific configuration for code formatting.
---@field pattern string[] # Pattern to match the files.
---@field formatters Formatter[] # Formatters to use.

local M = {}
---@type Formatter[]
M.active_formatters = {}

---Setup code formatter autocommands.
---@param config FormatConfig # Language specific configuration.
---@param group any # Neovim augroup.
function M.setup_code_format_autocmd(config, group)
	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "BufEnter" }, {
		group = group,
		desc = "Sets the current code formatter.",
		pattern = config.pattern,
		callback = function(_)
			M.active_formatters = config.formatters
		end,
	})
end

---Executes the current formatters if available.
function M:format_buffer()

	for _, formatter in pairs(self.active_formatters) do
		if formatter and vim.fn.executable(formatter.executable) == 1 then
			local filename = vim.api.nvim_buf_get_name(0)
			vim.cmd("silent! write")
			vim.cmd("silent! " .. formatter.cmd_fn(filename))
			vim.cmd("silent! edit")
		end
	end
end

---Setup function
---@param configs table<string, FormatConfig> # Map of language names to their format configurations.
function M:setup(configs)
	local group = vim.api.nvim_create_augroup("CodeFormat", {})
	for _, config in pairs(configs) do
		self.setup_code_format_autocmd(config, group)
	end
end

return M
