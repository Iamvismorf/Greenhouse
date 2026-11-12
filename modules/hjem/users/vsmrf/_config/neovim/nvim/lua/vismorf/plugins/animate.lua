local map = vim.keymap.set

map("n", "H", ':lua MiniAnimate.execute_after("scroll", "normal! Hzz")<CR>', { silent = true })
map("n", "L", ':lua MiniAnimate.execute_after("scroll", "normal! Lzz")<CR>', { silent = true })

return {
	"mini.animate",
	after = function()
		require("mini.animate").setup({
			cursor = {
				enable = false,
			},
		})
		vim.opt.mousescroll = "ver:1,hor:6" --todo: breaks blink cmp doc scroll
		-- vim.api.nvim_set_hl(0, "MiniAnimateCursor", { fg = "NONE", bg = "NONE" })
	end,
}
