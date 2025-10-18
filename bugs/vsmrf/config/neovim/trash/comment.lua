return {
	"comment.nvim",
	-- for_cat = "general.extra",
	event = "DeferredUIEnter",
	after = function()
		require("Comment").setup({
			padding = true,
			ignore = "^$", -- ignore line

			toggler = {
				line = "<leader>cc",
				block = "<leader>bc",
			},

			-- awaiting toggle/ toggle in visual
			opleader = {
				line = "<leader>c",
				block = "<leader>b",
			},

			extra = {
				above = "<leader>cO", -- Add comment on the line above
				below = "<leader>co", -- Add comment on the line below
				eol = "<leader>cA", -- Add comment at the end of line
			},
		})
	end,
}
