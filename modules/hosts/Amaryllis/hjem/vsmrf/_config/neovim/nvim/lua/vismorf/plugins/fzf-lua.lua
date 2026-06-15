return {
	"fzf-lua",
	event = { "DeferredUIEnter", "LspAttach" },
	keys = {
		{
			"<leader>f",
			function()
				require("fzf-lua").files()
			end,
		},
		{
			"<leader>g",
			function()
				require("fzf-lua").live_grep({ resume = true })
			end,
		},
	},
	after = function()
		require("fzf-lua").setup({
			files = {
				hidden = true,
				follow = true,
				cwd_prompt = false,
			},
			grep = {
				hidden = true,
				follow = true,
			},
		})
	end,
}
