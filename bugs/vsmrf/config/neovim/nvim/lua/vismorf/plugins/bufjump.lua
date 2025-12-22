return {
	"bufjump.nvim",
	after = function()
		require("bufjump").setup({
			forward_key = false,
			backward_key = false,
			forward_same_buf_key = "<M-.>",
			backward_same_buf_key = "<M-,>",
			on_success = function()
				print("hi")
			end,
		})
	end,
}
