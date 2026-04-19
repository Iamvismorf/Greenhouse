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
