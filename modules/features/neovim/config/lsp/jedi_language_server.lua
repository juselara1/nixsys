return {
	cmd = { "jedi-language-server" },
	filetypes = { "python" },
	root_dir = function(bufnr, on_dir)
		local root = vim.fs.root(bufnr, { ".git", "pyproject.toml" })
		if root then
			on_dir(root)
		end
	end,
}
