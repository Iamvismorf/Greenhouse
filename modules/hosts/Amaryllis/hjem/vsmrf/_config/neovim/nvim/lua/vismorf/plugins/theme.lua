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
				}
			end,
		})
		vim.cmd.colorscheme("zen")
	end,
}
