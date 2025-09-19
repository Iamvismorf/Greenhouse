return {
	"bufferline.nvim",
	after = function()
		require("bufferline").setup({
			options = {
				separator_style = "slope",
				enforce_regular_tabs = true,
				indicator = {
					style = "underline",
				},
				right_mouse_command = nil,
				close_command = function(bufnum)
					-- vim.api.nvim_command("BufDel" .. bufnum)
					require("snacks").bufdelete.delete(bufnum)
				end,
				offsets = {
					{
						filetype = "neo-tree",
						-- text = "Neotree",
						highlight = "Directory",
						-- separator = true,
					},
				},
			},
		})
		local map = vim.keymap.set
		local opts = { noremap = true, silent = true }

		map("n", "<Tab>", ":BufferLineCycleNext<cr>", opts)
		map("n", "<S-Tab>", ":BufferLineCyclePrev<cr>", opts)

		map("n", ">", ":BufferLineMoveNext<cr>", opts)
		map("n", "<", ":BufferLineMovePrev<cr>", opts)

		-- map("n", "<leader>x", ":BufDel<cr>", opts)

		map("n", "<leader>x", function()
			require("snacks").bufdelete.delete()
		end, opts)
	end,
}
