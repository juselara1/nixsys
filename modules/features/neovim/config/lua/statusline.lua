local fn = require("functions")

local M = {}

---Component for spacing.
---@param n_spaces integer # Number of spaces.
---@return string # Spaces.
function M.spaces(n_spaces)
	local spaces = ""
	for _ = 1, n_spaces do
		spaces = spaces .. " "
	end
	return spaces
end

---Component that displays the current git branch.
---@return string # Git branch.
function M.git_branch()
	local branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
	if branch ~= "" then
		return (" %s"):format(branch)
	else
		return branch
	end
end

---Component that displays the filetype icon.
---@return string # Filetype icon
function M.filetype()
	local ft = vim.bo.filetype
	local icons = {
		lua = "",
		python = "",
		c = "",
		cpp = "",
		json = "",
		markdown = "",
		javascript = "",
		html = "",
		css = "",
		vim = "",
		sh = "",
		rust = "",
		yaml = "",
		toml = "",
		make = "",
	}
	if ft == "" then
		return ""
	end
	return icons[ft]
end

---Component that displays the filename.
---@return string # Filename.
function M.filename()
	if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
		return ("%s"):format(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t"))
	else
		return "[No Name]"
	end
end

---Component that displays the current vim mode.
---@return string # Filetype icon
function M.vim_mode()
  local mode = vim.fn.mode()
	if fn.in_table({ "n", "no" }, mode) then
		return "λ Normal "
	elseif fn.in_table({ "R", "Rv" }, mode) then
		return "ω Replace"
	elseif fn.in_table({ "s", "S", "\x13" }, mode) then
		return "Γ Select "
	elseif fn.in_table({ "c", "cv", "ce" }, mode) then
		return "π Command"
	elseif fn.in_table({ "r", "rm", "r?" }, mode) then
		return "σ Prompt "
	elseif "v" == mode then
		return "β Visual "
	elseif "V" == mode then
		return "β VisualL"
	elseif "\x16" == mode then
		return "α Insert "
	elseif "i" == mode then
		return "α Insert "
	elseif "t" == mode then
		return "Φ Term   "
	else
		return mode
	end
end

---Component that displays if the buffer has been modified.
---@return string # Modified buffer.
function M.modified()
	if vim.bo.modified then
		return "●"
	else
		return ""
	end
end

---Component that displays the progress percentage.
---@return string # Progress.
function M.progress_bar()
	local bar = { "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
	local prop = vim.api.nvim_win_get_cursor(0)[1] / vim.api.nvim_buf_line_count(0)
	return bar[math.ceil(prop * #bar)]
end

---Component that displays a progress bar.
---@return string # Progress bar.
function M.progress()
	local prop = vim.api.nvim_win_get_cursor(0)[1] / vim.api.nvim_buf_line_count(0)
	return ("%d %%"):format(math.ceil(prop * 100))
end

---Component that aligns items in the statusbar.
---@return string # Align
function M.align()
  return "%="
end

---@class Component # Defines a statusline component.
---@param elements string[] # Elements that represent this component.
---@param hl string # Highlight to use for this component.
---@param reset_hl string # Highlight to use for reset.

---@class Highlight # Defines a statusbar highligthing.
---@param name string # Name of the highlight group.
---@param fg string # Color to use in the foreground.
---@param bg string # Color to use in the background.
---@param bold boolean # Defines if text must be bold.

---@class StatusLineConfig # Configuration for the statusline.
---@param components Component[] # Components to use.
---@param highlights Highlight[] # Highlights to use.

---Setup the highlight groups.
---@param highlights Highlight[] # Highlights to create.
local function set_highlight_groups(highlights)
  for _, highlight in pairs(highlights) do
    vim.api.nvim_set_hl(0, highlight.name, {fg = highlight.fg, bg=highlight.bg, bold=highlight.bold})
  end
end

---Setup the statusline.
---@param components Component[] # Components to use.
local function set_statusline(components)
  local statusline = ""
  for _, component in pairs(components) do
    statusline = statusline .. "%#" .. component.hl .. "#"
    for _, element in pairs(component.elements) do
      if element == "align()" then
        statusline = statusline .. M.align()
      else
        statusline = statusline .. "%{v:lua.require('statusline')." .. element .. "}"
      end
    end
    statusline = statusline .. "%#" .. component.reset_hl .. "#"
  end
  local group = vim.api.nvim_create_augroup("StatusLine", {})
	vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
		group = group,
		desc = "Sets the statusline.",
		callback = function(_)
			vim.opt_local.statusline = statusline
    end,
	})
end

---Setup for the statusline
---@param config StatusLineConfig # Configuration for the statusline.
function M.setup(config)
  set_highlight_groups(config.highlights)
  set_statusline(config.components)
end


return M
