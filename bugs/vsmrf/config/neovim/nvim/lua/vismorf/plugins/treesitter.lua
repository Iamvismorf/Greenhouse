vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo[0][0].foldmethod = "expr"
vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
vim.api.nvim_create_autocmd("FileType", {
	pattern = { ".nix", ".lua", ".cpp", ".c", ".qml" },
	callback = function()
		vim.treesitter.start()
	end,
})

return {
	"nvim-treesitter",
	lazy = false,
	after = function()
		require("nvim-treesitter").setup({})
	end,
}
