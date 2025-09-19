return {
	{
		"barbecue.nvim",
		-- event = "VimEnter",
		after = function()
			require("barbecue").setup({
				show_dirname = false,
				show_modified = true,
			})
		end,
	},
	{
		"nvim-navic",
		dep_of = { "barbecue.nvim" },
	},
}
