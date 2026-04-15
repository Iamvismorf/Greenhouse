-- motherfucker, don't delete this again
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.cmd.clearjumps()
	end,
})
return {
	"bufjump.nvim",
	event = "DeferredUIEnter",
	after = function()
		require("bufjump").setup({
			forward_key = false,
			backward_key = false,
			forward_same_buf_key = "<M-.>",
			backward_same_buf_key = "<M-,>",
		})
	end,
}
