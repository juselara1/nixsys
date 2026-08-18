local M = {}

---@class NetrwConfig
---@param width_ratio int # Width of Netrw file explorer.
---@param min_columns int # Minimum number of columns.

---@type NetrwConfig
M.config = {
  width_ratio = 25,
  min_columns = 80
}

---Calculate a dynamic netrw_winsize based on terminal width.
---At max terminal size it goes to config.width. Otherwise grows until
---90%.
---@return integer
function M:get_winsize()
  if vim.o.columns < self.config.min_columns then
    return 90
  else
    return self.config.width_ratio
  end
end

---Setup netrw configs
function M:setup_netrw()
	vim.g.netrw_banner = 0
	vim.g.netrw_liststyle = 3
	vim.g.netrw_browse_split = 4
	vim.g.netrw_altv = 1
	vim.g.netrw_winsize = self:get_winsize()
	vim.g.netrw_bufsettings = "noma nomod nu rnu nobl ro"
end

---Setup resize autocmd
function M.setup_resize_autocmd()
	vim.api.nvim_create_autocmd("VimResized", {
		desc = "Update netrw winsize on window resize",
		callback = function()
			vim.g.netrw_winsize = M:get_winsize()
		end,
	})
end

---Setups the netrw file explorer.
---@param config NetrwConfig # Netrw config.
function M:setup(config)
  self.config = vim.tbl_deep_extend("force", self.config, config or {})
  self:setup_netrw()
  self:setup_resize_autocmd()
end

return M
