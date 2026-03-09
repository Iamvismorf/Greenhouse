return {
	"fzf-lua",
	event = { "BufReadPre", "BufNewFile", "LspAttach" },
	keys = {
		{
			"<leader>ff",
			function()
				require("fzf-lua").files()
			end,
		},
		{
			"<leader>fg",
			function()
				require("fzf-lua").live_grep()
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
