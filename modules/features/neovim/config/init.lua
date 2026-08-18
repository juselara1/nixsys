local options = require("options")
options.setup({
	options = {
		function()
			options.set_colorscheme({ name = "habamax", theme = options.Theme.dark })
		end,
		options.set_cursor,
		options.set_files,
		options.set_indentation,
		options.set_numbers,
		options.set_text,
		options.set_cmd,
		options.set_columns,
		options.set_yank,
		options.set_match,
		options.set_display,
		options.set_ui,
		options.set_buffers,
		options.set_project,
	},
})

local keybindings = require("keybindings")
keybindings.setup({
	keybindings = {
		keybindings.set_leader,
		keybindings.set_list,
		keybindings.set_paste,
		keybindings.set_scroll,
		keybindings.set_search,
		keybindings.set_spell,
		keybindings.set_explorer,
		keybindings.set_indent,
		keybindings.set_term,
		keybindings.set_format,
	},
})

require("explorer"):setup({})
require("lsp_config").setup({ servers = { "lua_ls", "zubanls", "jedi_language_server", "nixd" } })
require("style").setup({
	lua = {
		pattern = { "*.lua" },
		num_spaces = 2,
		expandtab = true,
		textwidth = 120,
	},
	python = {
		pattern = { "*.py" },
		num_spaces = 4,
		expandtab = true,
		textwidth = 88,
		colorcolumn = 88,
	},
	c = {
		pattern = { "*.c", "*.h" },
		num_spaces = 2,
		expandtab = true,
		textwidth = 80,
		colorcolumn = 80,
	},
	sh = {
		pattern = { "*.sh" },
		num_spaces = 4,
		expandtab = true,
		textwidth = 80,
	},
	json = {
		pattern = { "*.json" },
		num_spaces = 2,
		expandtab = true,
	},
	toml = {
		pattern = { "*.toml" },
		num_spaces = 2,
		expandtab = true,
	},
	yaml = {
		pattern = { "*.yaml", "*.yml" },
		num_spaces = 2,
		expandtab = true,
	},
})

require("format"):setup({
	lua = {
		pattern = { "*.lua" },
		formatters = {
			{
				executable = "stylua",
				cmd_fn = function(filename)
					return "!stylua " .. filename
				end,
			},
		},
	},
	python = {
		pattern = { "*.py" },
		formatters = {
			{
				executable = "ruff",
				cmd_fn = function(filename)
					return "!ruff format " .. filename
				end,
			},
		},
	},
	c = {
		pattern = { "*.c", "*.h" },
		formatters = {
			{
				executable = "clang-format",
				cmd_fn = function(filename)
					return "!clang-format -style=llvm -i " .. filename
				end,
			},
		},
	},
	json = {
		pattern = { "*.json" },
		formatters = {
			{
				executable = "jq",
				cmd_fn = function(_)
					return "%!jq"
				end,
			},
		},
	},
  nix = {
    pattern = { "*.nix" },
    formatters = {
      {
        executable = "nixfmt",
        cmd_fn = function(filename)
          return "!nixfmt " .. filename
        end,
      }
    },
  },
})
require("lint"):setup({
	lua = {
		pattern = { "*.lua" },
		linters = {
			{
				executable = "luacheck",
				cmd = "luacheck --no-color .",
				ef = "%f:%l:%c: %m",
			},
		},
	},
	python = {
		pattern = { "*.py" },
		linters = {
			{
				executable = "mypy",
				cmd = "mypy --show-column-numbers .",
				ef = "%f:%l:%c: %m",
			},
			{
				executable = "ruff",
				cmd = "ruff check --output-format concise .",
				ef = "%f:%l:%c: %m",
			},
			{
				executable = "ty",
				cmd = "ty check --output-format concise .",
				ef = "%f:%l:%c: %m",
			},
		},
	},
})
require("statusline").setup({
	highlights = {
		{ name = "StatusLineBase", fg = "#BCBCBC", bg = "#585858", bold = false },
		{ name = "StatusLineMode", fg = "#5FAF5F", bg = "#585858", bold = true },
		{ name = "StatusLineBranch", fg = "#AF87AF", bg = "#585858", bold = false },
		{ name = "StatusLineModified", fg = "#AF5F5F", bg = "#585858", bold = false },
	},
	components = {
		{
			elements = { "spaces(3)", "vim_mode()", "spaces(2)" },
			hl = "StatusLineMode",
			reset_hl = "StatusLineBase",
		},
		{
			elements = { "spaces(1)", "git_branch()", "spaces(1)" },
			hl = "StatusLineBranch",
			reset_hl = "StatusLineBase",
		},
		{
			elements = { "align()" },
			hl = "StatusLineBase",
			reset_hl = "StatusLineBase",
		},
		{
			elements = { "filetype()", "spaces(1)", "filename()", "spaces(1)" },
			hl = "StatusLineBase",
			reset_hl = "StatusLineBase",
		},
		{
			elements = { "modified()" },
			hl = "StatusLineModified",
			reset_hl = "StatusLineBase",
		},
		{
			elements = { "align()" },
			hl = "StatusLineBase",
			reset_hl = "StatusLineBase",
		},
		{
			elements = { "spaces(1)", "progress()", "spaces(1)" },
			hl = "StatusLineBase",
			reset_hl = "StatusLineBase",
		},
		{
			elements = { "spaces(1)", "progress_bar()", "spaces(1)" },
			hl = "StatusLineBase",
			reset_hl = "StatusLineBase",
		},
	},
})
