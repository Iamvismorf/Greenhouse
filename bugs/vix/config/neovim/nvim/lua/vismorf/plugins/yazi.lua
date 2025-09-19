-- toggle is weird when reopening with directory
return {
	"yazi.nvim",
	keys = {
		{
			"<C-n>",
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
