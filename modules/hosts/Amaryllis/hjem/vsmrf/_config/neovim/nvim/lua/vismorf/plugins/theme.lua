vim.o.cursorline = true

return {
	"zen.nvim",
	lazy = false,
	priority = 1000,
	after = function()
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
					TreesitterContextSeparator = { fg = colors.palette.rose },
					IblIndent = { fg = colors.palette.bg4, nocombine = true },
					IblScope = { fg = colors.palette.sage, nocombine = true },
					MatchParen = { fg = colors.theme.diag.warning, underdouble = true },
				}
			end,
		})
		vim.cmd.colorscheme("zen")
	end,
}
