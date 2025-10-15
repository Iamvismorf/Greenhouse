-- toggle is weird when reopening with directory
return {
	"yazi.nvim",
	keys = {
		{
			"<C-n>",
			mode = { "n", "i" },
			function()
				require("yazi").toggle()
			end,
		},
	},
	after = function()
		require("yazi").setup({
			open_for_directories = false,
		})
	end,
}
