vim.o.cursorline = true
require("kanso").setup({
	italics = false,
	undercurl = false,
	colors = {
		theme = {
			ink = {
				ui = {
					float = {
						fg_border = require("kanso.colors").setup({ theme = "ink" }).palette.inkGray2,
					},
				},
			},
		},
	},
	overrides = function(c)
		return {
			WinSeparator = { fg = c.palette.inkGray2 },
			["@string.special.url"] = { fg = c.theme.syn.special1, undercurl = false },
		}
	end,
})
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
})
