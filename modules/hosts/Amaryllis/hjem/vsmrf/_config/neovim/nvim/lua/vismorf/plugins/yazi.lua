return {
	"yazi.nvim",
	keys = {
		{
			"<C-n>",
			mode = { "n", "i" },
			function()
				require("yazi").yazi()
			end,
			desc = "Open yazi at the current file",
		},
	},
	after = function()
		require("yazi").setup({
			open_for_directories = false,
		})
	end,
}
