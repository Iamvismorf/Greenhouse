return {
	"nvim-treesitter-context",
	event = "DeferredUIEnter",
	after = function()
		require("treesitter-context").setup({
			max_lines = 2,
			separator = "-",
		})
	end,
}
