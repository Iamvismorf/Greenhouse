#TODO: show cursor position instead of procent on right far right
return {
	"lualine.nvim",
	after = function()
		require("lualine").setup({
			options = {
				disabled_filetypes = {
					statusline = { "neo-tree" },
				},
			},
			sections = {
				lualine_a = {
					{
						"mode",
						icons_enabled = true,
						-- icon = '󰮬 ',
						icon = "󱎶 ",
					},
				},
				lualine_b = { { "branch" } },
				lualine_c = {
					{
						"filename",
						path = 3,
					},
				},
				lualine_x = {
					{
						"diagnostics",
						symbols = {
							error = " ",
							warn = " ",
							hint = "󰌵 ",
							info = " ",
						},
					},
					{ "diff" },
				},
				lualine_y = { { "filetype" } },
				lualine_z = { "location" },
			},
		})
	end,
}
