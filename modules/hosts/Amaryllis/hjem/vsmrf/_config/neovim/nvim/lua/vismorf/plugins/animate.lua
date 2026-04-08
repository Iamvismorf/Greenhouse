return {
	"mini.animate",
	after = function()
		require("mini.animate").setup()
		vim.api.nvim_set_hl(0, "MiniAnimateCursor", { fg = "NONE", bg = "NONE" })
	end,
}
