-- motherfucker, don't delete this again
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.cmd.clearjumps()
	end,
})
local opts = { silent = true, noremap = true }
vim.api.nvim_set_keymap("n", "<S-k>", ":lua require('bufjump').forward()<cr>", opts)
vim.api.nvim_set_keymap("n", "<S-j>", ":lua require('bufjump').backward()<cr>", opts)
return {
	"bufjump.nvim",
	event = "DeferredUIEnter",
	after = function()
		require("bufjump").setup({
			-- forward_key = "<C-.>",
			-- backward_key = "<C-,>",
			-- forward_key = "<S-k>",
			-- backward_key = "<S-j>",
			forward_key = false,
			backward_key = false,
			forward_same_buf_key = "<M-.>",
			backward_same_buf_key = "<M-,>",
		})
	end,
}
