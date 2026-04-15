local load_w_after = function(name)
	vim.cmd.packadd(name)
	vim.cmd.packadd(name .. "/after")
end
vim.api.nvim_create_autocmd("InsertEnter", {
	callback = function()
		vim.g.showMenu = true
	end,
})
return {
	{
		"friendly-snippets",
		dep_of = { "blink.cmp" },
	},
	{
		"lspkind.nvim",
		dep_of = { "blink.cmp" },
		load = load_w_after,
	},
	{
		"blink.cmp",
		keys = {
			{
				"<C-e>",
				function()
					if vim.g.showMenu then
						require("blink.cmp").hide()
						vim.api.nvim_echo({ { "cmp menu hidden", "DiagnosticInfo" } }, false, {})
					else
						vim.api.nvim_echo({ { "cmp menu on", "DiagnosticInfo" } }, false, {})
					end
					vim.g.showMenu = not vim.g.showMenu
				end,
				mode = { "i" },
				desc = "Toggle completions",
			},
		},
		event = { "InsertEnter", "DeferredUIEnter" },
		after = function()
			require("blink.cmp").setup({
				enabled = function()
					return vim.g.showMenu
				end,
				keymap = {
					preset = "none",

					["<C-space>"] = { "accept" },
					["<C-b>"] = { "scroll_documentation_up", "fallback" },
					["<C-f>"] = { "scroll_documentation_down", "fallback" },

					["<C-k>"] = { "select_prev", "fallback" },
					["<C-j>"] = { "select_next", "fallback" },
				},
				cmdline = {
					keymap = {
						preset = "none",

						["<C-k>"] = { "select_prev", "fallback" },
						["<C-j>"] = { "select_next", "fallback" },
					},
					completion = {
						menu = {
							auto_show = true,
						},
						list = {
							selection = {
								preselect = false,
								auto_insert = true,
							},
						},
					},
				},

				appearance = {
					nerd_font_variant = "normal",
				},

				completion = {
					list = {
						selection = {
							preselect = false,
						},
					},
					documentation = { auto_show = true },

					menu = {
						scrollbar = false,
						draw = {
							gap = 8,
							padding = 1,
							columns = function()
								if vim.api.nvim_get_mode().mode == "c" then
									return { { "kind_icon", "label", gap = 2 } }
								else
									return { { "kind_icon", "label", "label_description", "source_name", gap = 1 } }
								end
							end,
							components = {
								source_name = {
									width = { fill = true },
									text = function(ctx)
										return ctx.source_name
									end,
									highlight = "BlinkCmpSource",
								},
							},
						},
					},
				},

				sources = {
					default = { "lsp", "path", "snippets", "buffer" },
				},
			})
		end,
	},
}
