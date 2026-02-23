-- toggle is weird when reopening with directory
return {
	"yazi.nvim",
	keys = {
		{
			"<C-n>",
			mode = { "n", "i" },
			"<cmd>Yazi<cr>", -- open in current file
			-- "<cmd>Yazi cwd<cr>", -- -- open in current working directory
		},
	},
	after = function()
		require("yazi").setup({
			open_for_directories = false,
		})
	end,
}
