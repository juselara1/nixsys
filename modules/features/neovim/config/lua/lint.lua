local fn = require("functions")

---@class Linter # Properties of a linter.
---@field executable string # Executable command to validate.
---@field cmd string # Command to execute.
---@field ef string # Errorformat for the linter.

---@class LintConfig # Language specific configuration for linting.
---@field pattern string[] # Pattern to match a programming language.
---@field linters Linter[] # Linters for a programming language.

local M = {}
---@type Linter[]
M.active_linters = {}

---Executes the linting process.
function M.lint_buffer()
	local valid_linters = fn.filter(function(linter)
		return vim.fn.executable(linter.executable) == 1
	end, M.active_linters)

	if #valid_linters == 0 then
		return
	end

	local function run_linter(linter)
		if linter.ef then
			vim.o.errorformat = linter.ef
		end
		local output = vim.fn.system(linter.cmd)
		vim.fn.setqflist({}, "r", { title = linter.executable, lines = vim.split(output, "\n") })
	end

	if #valid_linters == 1 then
		run_linter(valid_linters[1])
	else
		vim.ui.select(
			fn.map(function(linter)
				return linter.executable
			end, valid_linters),
			{ prompt = "Select a linter:" },
			function(executable)
				local linter = fn.filter(function(linter)
					return linter.executable == executable
				end, valid_linters)[1]
				if linter then run_linter(linter) end
			end
		)
	end
end

---Setup lint autocommands.
---@param config LintConfig # Language specific configuration.
---@param group any # Neovim augroup.
function M.setup_lint_autocmd(config, group)
	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "BufEnter" }, {
		group = group,
		desc = "Sets the current linters.",
		pattern = config.pattern,
		callback = function(_)
			M.active_linters = config.linters
		end,
	})
end

---Setup function
---@param configs table<string, LintConfig> # Map of language names to their lint configurations.
function M:setup(configs)
	local group = vim.api.nvim_create_augroup("Lint", {})
	for _, config in pairs(configs) do
		self.setup_lint_autocmd(config, group)
	end

	vim.api.nvim_create_user_command("Lint", function(_)
		self.lint_buffer()
	end, {
		nargs = 0,
		desc = "Run the current linter.",
	})
end

return M
