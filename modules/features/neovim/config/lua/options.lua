local M = {}

---Setups the configuration for line numbers.
function M.set_numbers()
	vim.o.number = true -- Line numbers.
	vim.o.relativenumber = true -- Relative line numbers
end

---Setups cursor configuration.
function M.set_cursor()
	vim.o.cursorline = true -- Highlight line in which the cursor is.
	vim.o.scrolloff = 10 -- Keep 10 lines above cursor.
	vim.o.sidescrolloff = 8 -- Keep 8 columns aside of cursor.
	vim.o.ruler = false -- Don't show cursor position.
	vim.o.mouse = "" -- Disable mouse.
end

---Setups default indentation.
function M.set_indentation()
	vim.o.tabstop = 2 -- Tab width.
	vim.o.shiftwidth = 2 -- Indent width.
	vim.o.softtabstop = 2 -- Soft tab stop.
	vim.o.expandtab = true -- Use spaces instead of tabs.
	vim.o.autoindent = true -- Copy indent of current line.
	vim.o.smartindent = true -- Smart autoindent
	vim.o.backspace = "indent,eol,start" -- Better backspace behavior.
end

---@enum M.Theme
M.Theme = {
  dark = "dark",
  light = "light"
}

---@class ColorSchemeConfig
---@param name string # Name of the colorscheme to use.
---@param theme Theme # Defines the theme.

---Setups colorscheme.
---@param config ColorSchemeConfig # Colorscheme configuration.
function M.set_colorscheme(config)
	vim.cmd(("colorscheme %s"):format(config.name)) -- Setup colorscheme.
	vim.o.background = config.theme -- Specify dark mode to color groups.
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" }) -- Transparent background.
	vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" }) -- Transparent background.
	vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" }) -- Transparent background.
	vim.o.winblend = 0 -- Transparency for popup windows.
end


---Setups text options.
function M.set_text()
	vim.o.encoding = "utf-8" -- Text encoding.
	vim.o.spelllang = "en,es" -- Text languages.
	vim.cmd.syntax("enable") -- Enable syntax checking.
	vim.o.wrap = true -- Wrap lines
	vim.o.conceallevel = 0 -- Show conceal text normally.
end

---Setup file handling
function M.set_files()
	vim.o.backup = false -- Don't create backups.
	vim.o.writebackup = false -- Don't create backup before writing.
	vim.o.swapfile = false -- Don't create swap files.
	vim.o.undofile = true -- Persistent undo.
	vim.o.undodir = vim.fn.expand("~/.vim/undodir") -- Undo directory.
	vim.o.updatetime = 100 -- Faster completion.
	vim.o.autowrite = false -- Don't autosave.
end

---Setup command line
function M.set_cmd()
	vim.o.showmode = false -- Don't show mode in command line.
	vim.o.showcmd = false -- Don't show partial commands.
end

---Setup columns
function M.set_columns()
	vim.o.signcolumn = "yes" -- Always show sign column.
	vim.o.colorcolumn = "150" -- Show column at 150 characters.
end

---Setup yanking
function M.set_yank()
	vim.o.clipboard = "unnamedplus" -- Use clipboard for all operations.
	vim.api.nvim_create_autocmd({ "TextYankPost" }, {
		desc = "Highlights yanked text",
		pattern = { "*" },
		callback = function(_)
			vim.highlight.on_yank({ higroup = "Visual", timeout = 400 })
		end,
	})
end

---Setups bracket matching.
function M.set_match()
	vim.o.showmatch = true -- Highlight matching brackets.
	vim.o.matchtime = 2 -- How long to show the matched brackets.
end

---Setups display/rendering.
function M.set_display()
	vim.o.termguicolors = true -- Enable 24 bit colors.
	vim.o.lazyredraw = true -- Don't redraw during macros.
	vim.o.listchars = "tab:→\\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»"
end

---Setups UI chrome.
function M.set_ui()
	vim.o.laststatus = 2 -- Create a statusline only if there're two windows.
	vim.o.errorbells = false -- No error bells.
	vim.o.shortmess = "I" -- Don't show startup message.
end

---Setups buffer management.
function M.set_buffers()
	vim.o.hidden = true -- Allow hidden buffers.
end

---Setups project/navigation behavior.
function M.set_project()
	vim.o.autochdir = false -- Don't change root directory when files are opened.
	vim.o.autoread = true -- Auto reload files changed outside vim.
end

---@alias Option fun():nil # Defines the options setup strategy interface.

---@class OptionsConfig
---@param options Option[] # Table of options to use.

---Setup function
---@param config OptionsConfig
function M.setup(config)
  for _, option in ipairs(config.options) do
    option()
  end
end

return M
