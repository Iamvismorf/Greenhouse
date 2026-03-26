vim.o.cursorline = true
require("zen").setup({
	variant = "dark",
	undercurl = false,
	colors = {
		palette = {
			bg0 = "#1C1D1F",
			sage = "#F08E8B",
			fg = "#D1CFCF",
		},
	},
	overrides = function(colors)
		return {
			WinSeparator = { fg = colors.palette.rose },
		}
	end,
})
