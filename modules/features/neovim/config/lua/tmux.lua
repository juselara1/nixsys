local fn = require("functions")

---Tmux pane dataclass.
---@class TmuxPane
---@field pane_id integer # Tmux pane index.
---@field pane_name string # Tmux pane name.

---Parse tmux pane info stdout.
---@param line string # Tmux pane info.
---@return TmuxPane | nil # Parsed tmux pane.
local function parse_pane_info_line(line)
	local id_start, id_end = string.find(line, "%%%d+")
	local name_start, name_end = string.find(line, "%a+:%d+%.%d+")
	if id_start == nil or id_end == nil or name_start == nil or name_end == nil then
		return nil
	end
	return {
		pane_id = line:sub(id_start, id_end),
		pane_name = line:sub(name_start, name_end),
	}
end

---Gets tmux pane info stdout.
---@return string[] # Tmux pane info stdout.
local function get_tmux_pane_info()
	local tmux_stdout = vim.fn.system("tmux list-panes -a")
	local lines = {}
	for line in tmux_stdout:gmatch("([^\n]+)") do
		table.insert(lines, line)
	end
	return lines
end

---Gets tmux panes.
---@return TmuxPane[] # Parsed tmux panes.
local function get_tmux_panes()
	local tmux_info = get_tmux_pane_info()
	local panes = fn.map(parse_pane_info_line, tmux_info)
	return fn.filter(function(v)
		return v ~= nil
	end, panes)
end

---Validates if there's at least one valid tmux pane.
---@param panes TmuxPane[] # Parsed tmux panes.
---@return boolean # Validation result
local function validate_tmux_panes(panes)
	if #panes == 0 then
		vim.notify(
			"Could not find any tmux pane, please validate that there's at least one pane.",
			vim.log.levels.ERROR
		)
		return false
	end
	return true
end

---Set target tmux pane.
---@param panes TmuxPane[] # List of parsed panes.
local function set_target_pane(panes)
	if not validate_tmux_panes(panes) then
		return
	end
	vim.ui.select(
		fn.map(function(pane)
			return pane.pane_id
		end, panes),
		{
			prompt = "Select a tmux pane:",
		},
		function(pane_id)
			vim.g.tmux_selected_pane = pane_id
		end
	)
end

---Validates if input pane id is valid.
---@param pane_id string # Input pane id.
---@param panes TmuxPane[] # Available panes.
---@return boolean # Validation.
local function validate_input_pane(pane_id, panes)
	local pane_ids = fn.map(function(pane)
		return pane.pane_id
	end, panes)
	if not fn.in_table(pane_ids, pane_id) then
		vim.notify("Invalid pane id. Please check available tmux panes.", vim.log.levels.ERROR)
		return false
	end
	return true
end

---Create user command to select the target tmux pane.
local function create_pane_selection_command()
	vim.api.nvim_create_user_command("TmuxPaneSelect", function(opts)
		local panes = get_tmux_panes()
		if #opts.fargs == 0 then
			set_target_pane(panes)
			return
		end
		local pane_id = opts.args
		if not validate_input_pane(pane_id, panes) then
			return
		else
			vim.g.tmux_selected_pane = pane_id
		end
	end, {
		nargs = "?",
		desc = "Select target tmux pane.",
		complete = function(_, _, _)
			local panes = get_tmux_panes()
			local pane_ids = fn.map(function(pane)
				return pane.pane_id
			end, panes)
			return pane_ids
		end,
	})
end

---Sends lines into a tmux pane.
---@param lines string[] # Lines to send.
---@param pane string # Target pane.
local function send_tmux_lines(lines, pane)
	local text = fn.strjoin(lines, "\n") .. "\n"
	local _ = vim.fn.jobstart(('tmux send -t %s "%s"'):format(pane, text), {
		on_stdout = nil,
		stdout_buffered = true,
	})
end

---Converts text to tmux-compatible lines.
---@param text string # Input text.
---@return string # Tmux-compatible text.
local function text_to_tmux(text)
	local clean_text, _ = text:gsub('"', '\\"')
	return clean_text
end

---Validates selected pane.
---@param pane_id string | nil # Candidate pane id.
---@return boolean # Validation
local function validate_selected_pane(pane_id)
	if pane_id == nil then
		vim.notify(
			"Please configure a target tmux pane using :TmuxSelectPane before sending lines.",
			vim.log.levels.ERROR
		)
		return false
	end
	return true
end

---Create line send user command.
local function create_line_send_command()
	vim.api.nvim_create_user_command("TmuxSendLines", function(opts)
		local pane_id = vim.g.tmux_selected_pane
		if not validate_selected_pane(pane_id) then
			return
		end
		local line_start = opts.line1 - 1
		local line_end = opts.line2
		local lines = vim.api.nvim_buf_get_lines(0, line_start, line_end, false)
		local preprocessed_lines = fn.map(text_to_tmux, lines)
		send_tmux_lines(preprocessed_lines, pane_id)
	end, { nargs = 0, range = true, desc = "Sends a range of lines to a tmux pane." })
end

---Sets tmux shortcuts.
local function create_tmux_shortcuts()
	vim.keymap.set("n", "tp", ":TmuxPaneSelect<CR>", { silent = true, noremap = true, desc = "[T]mux [P]ane" })
	vim.keymap.set({ "n", "v" }, "ts", ":TmuxSendLines<CR>", { silent = true, noremap = true, desc = "[T]mux [S]end" })
end

---Main entrypoint.
local function main()
	create_pane_selection_command()
	create_line_send_command()
	create_tmux_shortcuts()
end

main()
