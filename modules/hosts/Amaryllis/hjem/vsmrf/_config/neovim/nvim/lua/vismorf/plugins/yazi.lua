return {
	"yazi.nvim",
	keys = {
		{
			"<C-n>",
			mode = { "n", "i" },
			function()
				require("yazi").yazi()
			end,
			-- "<cmd>Yazi cwd<cr>", -- -- open in current working directory
		},
	},
	after = function()
		require("yazi").setup({
			open_for_directories = false,
		})
	end,
}
