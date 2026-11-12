return {
	"flash.nvim",
	event = "DeferredUIEnter",

	after = function()
		require("flash").setup({
			modes = {
				search = {
					enabled = false,
				},
			},
		})
	end,
}
