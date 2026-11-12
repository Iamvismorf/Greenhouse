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
							auto_show = function(ctx, _)
								return ctx.mode == "cmdwin"
							end,
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
				fuzzy = {
					implementation = "rust",
					prebuilt_binaries = { download = false },
				},
				signature = { enabled = true },

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
							padding = 2,
							columns = function(ctx)
								if ctx.mode == "cmdwin" then
									return { { "kind_icon", "label" } }
								else
									return {
										{ "kind_icon", "label" },
										{ "label_description", gap = 6 },
										{ "kind", "source_name", gap = 2 },
									}
								end
							end,
							components = {
								kind_icon = { width = { fill = false } },
								kind = { width = { fill = true } },
								space = {
									text = function(ctx)
										return string.rep(" ", math.max(1, ctx.self.gap))
									end,
									width = { fill = true },
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
