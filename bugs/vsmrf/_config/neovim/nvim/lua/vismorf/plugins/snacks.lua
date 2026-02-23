return {
	"snacks.nvim",
	after = function()
		require("snacks").setup({
			bigfile = { enabled = true },
			bufdelete = { enabled = true },
			picker = { enabled = true },

			scroll = {
				enabled = true,
				animate = {
					duration = { step = 30, total = 250 },
					easing = "linear",
				},
				animate_repeat = {
					duration = { step = 0, total = 2 },
				},
			},
		})
	end,
}
