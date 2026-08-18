return {
	cmd = { "nixd" },
	filetypes = { "nix" },
	root_dir = function(bufnr, on_dir)
		local root = vim.fs.root(bufnr, { "flake.nix", ".git" })
		if root then
			on_dir(root)
		end
	end,
}
