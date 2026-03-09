vim.g.indent_blankline_use_treesitter = false

return {
	"indent-blankline.nvim",
	after = function()
		require("ibl").setup({
			indent = {
				char = "│",
			},
			scope = {
				show_start = false,
				-- show_end = false,
				include = {
					node_type = {
						["*"] = { "*" },
					},
				},
			},
		})
	end,
}
