local base_on_attach = require("vismorf.lsp.on_attach")
vim.lsp.config("*", {
	on_attach = base_on_attach,
})

vim.lsp.config("rust_analyzer", {
	on_attach = function(client, bufnr)
		base_on_attach(client, bufnr)
		vim.lsp.inlay_hint.enable(true)
	end,
})

vim.lsp.enable({
	"lua_ls",
	"nixd",
	"clangd",
	"neocmake",
	"qmlls",
	"glsl_analyzer",
	"glslls",
	"rust_analyzer",
})
