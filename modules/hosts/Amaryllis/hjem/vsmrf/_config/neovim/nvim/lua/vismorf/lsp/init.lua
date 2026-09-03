vim.lsp.config("*", {
	on_attach = require("vismorf.lsp.on_attach"),
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
