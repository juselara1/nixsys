local M = {}

---@class LspConfig # Configuration for the LSP client.
---@param servers string[] # List of LSP servers to configure.

--- Setups the LSP.
---@param config LspConfig
function M.setup(config)
	vim.diagnostic.enable(false)
	vim.lsp.enable(config.servers)
end

return M
