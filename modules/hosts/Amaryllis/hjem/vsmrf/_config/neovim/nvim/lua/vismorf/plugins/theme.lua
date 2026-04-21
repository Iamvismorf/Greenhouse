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
					bg0 = "#0C0B0F",
					sage = "#F08E8B",
					fg = "#E3E2E5",
				},
			},
			overrides = function(colors)
				return {
					--custom
					WinbarFileName = { fg = colors.palette.fg },
					StatusLineFileName = { fg = colors.palette.sage },
					StatusLineError = { fg = colors.palette.diag_error },
					StatusLineOk = { fg = colors.palette.diag_ok },

					--theme
					WinSeparator = { fg = colors.palette.sage },
					TreesitterContextSeparator = { fg = colors.palette.rose },
					IblIndent = { fg = colors.palette.bg4, nocombine = true },
					IblScope = { fg = colors.palette.sage, nocombine = true },
					MatchParen = { fg = colors.theme.diag.warning, underdouble = true },
					FloatBorder = {
						fg = colors.palette.fg_muted,
					},
				}
			end,
		})
		vim.cmd.colorscheme("zen")
	end,
}
