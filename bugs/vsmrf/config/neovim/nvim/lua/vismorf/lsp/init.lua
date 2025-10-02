-- local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = require("vismorf.lsp.on_attach"),
})

local flags = {
	allow_incremental_sync = true,
	debounce_text_changes = 200,
}
vim.lsp.config("*", {
	-- capabilities = capabilities,
	flags = flags,
})

vim.lsp.enable({
	"lua_ls",
	"nixd",
	"clangd",
	"neocmake",
})
