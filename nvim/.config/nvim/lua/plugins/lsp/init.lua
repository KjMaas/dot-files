-- import LSP config, our installer and our handlers
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("plugins.lsp.mason")
require("plugins.lsp.mason-lspconfig")
require("plugins.lsp.handlers").setup()
require("plugins.lsp.null-ls")
