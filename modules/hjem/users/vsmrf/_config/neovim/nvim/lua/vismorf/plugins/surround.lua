vim.g.nvim_surround_no_normal_mappings = true
return {
	"nvim-surround",
	event = "DeferredUIEnter",
	keys = {
		{
			mode = "n",
			"<leader>s",
			"<Plug>(nvim-surround-normal)",
		},
	},
	after = function()
		require("nvim-surround").setup()
	end,
}
