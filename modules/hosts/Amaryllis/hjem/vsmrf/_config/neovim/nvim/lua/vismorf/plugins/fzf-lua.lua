-- '-- *.lua *.nix' to filter by filetype
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
				require("fzf-lua").live_grep({ resume = true, no_esc = true })
			end,
		},
		{
			"<C-b>",
			function()
				require("fzf-lua").buffers({
					actions = { ["ctrl-b"] = function() end },
					-- fzf_opts = { ["--header-lines"] = 0 },
				})
			end,
		},
	},
	after = function()
		require("fzf-lua").setup({
			fzf_opts = {
				["--cycle"] = true,
			},
			files = {
				hidden = true,
				follow = true,
				cwd_prompt = false,
			},
			grep = {
				hidden = true,
				follow = true,
			},
			winopts = {
				preview = {
					wrap = true,
				},
			},
		})
	end,
}
