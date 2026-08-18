local M = {}

---Setups keybindings configs.
function M.set_leader()
	vim.g.mapleader = " "
end

---Setups formatting keybindings.
function M.set_format()
	vim.keymap.set("n", "<leader>cf", function()
		local format = require("format")
		format:format_buffer()
	end, { silent = true, noremap = true, desc = "[C]ode [F]ormat" })
end

---Setup search keybindings.
function M.set_search()
	vim.keymap.set("n", "<leader>cs", ":noh<CR>", { silent = true, noremap = true, desc = "[C]lear [S]earch" })
	vim.keymap.set("n", "n", "nzzzv", { silent = true, noremap = true, desc = "[N]ext search result (centered)." })
	vim.keymap.set("n", "N", "Nzzzv", { silent = true, noremap = true, desc = "Previous search result (centered)." })
end

---Setup scroll keybindings.
function M.set_scroll()
	vim.keymap.set("n", "<C-d>", "<C-d>zz", { silent = true, noremap = true, desc = "Half page down (centered)." })
	vim.keymap.set("n", "<C-u>", "<C-u>zz", { silent = true, noremap = true, desc = "Half page up (centered)." })
end

---Setup spell keybindings.
function M.set_spell()
	vim.keymap.set(
		"n",
		"<leader>ss",
		":set spell!<CR>",
		{ silent = true, noremap = true, desc = "[S]et [S]pell (toggle spellchecking)" }
	)
end

---Setup list keybindings.
function M.set_list()
	vim.keymap.set(
		"n",
		"<leader>sl",
		":set list!<CR>",
		{ silent = true, noremap = true, desc = "[S]et [L]ist (toggle non-visible characters)" }
	)
end

---Setup paste keybindings.
function M.set_paste()
	vim.keymap.set("n", "<leader>P", '"+p', { silent = true, noremap = true, desc = "[P]aste from system clipboard" })
	vim.keymap.set("n", "<leader>p", '"0p', { silent = true, noremap = true, desc = "[P]aste last yanked text" })
end

---Setups terminal keybindings
function M.set_term()
	vim.keymap.set(
		"t",
		"<C-q>",
		"<Esc><C-\\><C-n>",
		{ silent = true, noremap = true, desc = "Normal mode from terminal mode" }
	)
end

---Setups indent keybindings
function M.set_indent()
	vim.keymap.set("v", "<", "<gv", { silent = true, noremap = true, desc = "Indent left and reselect" })
	vim.keymap.set("v", ">", ">gv", { silent = true, noremap = true, desc = "Indent right and reselect" })
end

---Setup netrw shortcuts.
function M.set_explorer()
	vim.keymap.set("n", "<leader>e", function()
		vim.g.netrw_winsize = require("explorer"):get_winsize()
		vim.cmd("Lexplore")
	end, {
		silent = false,
		noremap = true,
		desc = "[E]xplorer (toggle netrw)",
	})
end

---@alias Keybinding fun():nil # Defines the keybindings to setup

---@class KeybindingConfig
---@param keybindings Keybinding[] # Table of keybindings to use.

---Setup function
---@param config KeybindingConfig
function M.setup(config)
	for _, keybind in ipairs(config.keybindings) do
		keybind()
	end
end

return M
