--TODO: customize cmp menu
local load_w_after = function(name)
	vim.cmd.packadd(name)
	vim.cmd.packadd(name .. "/after")
end
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
		event = { "InsertEnter", "DeferredUIEnter" },
		after = function()
			require("blink.cmp").setup({
				keymap = {
					preset = "enter",
					["<C-p>"] = {},
					["<C-n>"] = {},
					-- ["<cr>"] = { "select_and_accept" },

					["<C-k>"] = { "select_prev" },
					["<C-j>"] = { "select_next" },
				},
				cmdline = {
					completion = {
						menu = {
							auto_show = true,
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
