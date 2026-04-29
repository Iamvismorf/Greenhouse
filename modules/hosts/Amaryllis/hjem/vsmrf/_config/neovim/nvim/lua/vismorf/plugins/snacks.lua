return {
	"snacks.nvim",
	after = function()
		require("snacks").setup({
			bigfile = { enabled = true },
			bufdelete = { enabled = true },
			picker = { enabled = true },
		})
	end,
}
