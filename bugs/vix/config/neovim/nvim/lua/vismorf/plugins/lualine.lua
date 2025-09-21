return {
	"lualine.nvim",
	after = function()
		require("lualine").setup({
			sections = {
				lualine_a = {
					{
						"mode",
						icons_enabled = true,
						-- icon = "󰮬 ",
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
