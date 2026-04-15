vim.g.indent_blankline_use_treesitter = false

return {
	"indent-blankline.nvim",
	event = "DeferredUIEnter",
	after = function()
		require("ibl").setup({
			indent = {
				-- char = "│",
				char = "╏",
				-- char = "┇",
			},
			scope = {
				show_start = false,
				show_end = false,
				include = {
					node_type = {
						["*"] = { "*" },
					},
				},
			},
		})
	end,
}
