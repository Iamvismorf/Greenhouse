return {
	{
		"neo-tree.nvim",
		after = function()
			vim.keymap.set({ "n", "v", "c", "i" }, "<C-n>", "<esc>:Neotree toggle right filesystem reveal<CR>")
			require("neo-tree").setup({

				close_if_last_window = true,
				-- name = {
				-- 	use_git_status_colors = false,
				-- 	highlight = "none",
				-- },
				default_component_configs = {
					indent = {
						with_expanders = true,
					},
				},
				source_selector = {
					winbar = false, -- disables the top bar
					statusline = false, -- disables from showing in the status line (if set)
				},

				filesystem = {
					follow_current_file = {
						enabled = true,
						leave_dirs_open = true,
					},
					filtered_items = {
						hide_dotfiles = false,
					},
					window = {
						width = 30,
						position = "right",
					},
				},
				-- default_component_configs = {
				--    indent = {
				--       padding = 2,
				--    }
				-- },
				window = {
					mappings = {
						["/"] = "noop",
						["f"] = "noop",
						["<esc>"] = "noop",
						["*"] = "expand_all_nodes",
						-- ["<cr>"] = "open",
						["<cr>"] = "open_with_window_picker",
					},
				},
				event_handlers = {
					{
						event = "neo_tree_buffer_enter",
						handler = function()
							-- vim.cmd("stopinsert")
							vim.opt.relativenumber = true
							vim.opt.nu = true
						end,
					},
					{
						event = "file_opened",
						handler = function()
							vim.cmd([[Neotree focus]])
						end,
					},
				},
			})
		end,
	},
	{
		"nui.nvim",
		dep_of = { "neo-tree.nvim" },
	},
	-- {
	-- 	"3rd/image.nvim",
	-- 	dep_of = { "neo-tree.nvim" },
	-- },
	{
		"nvim-window-picker",
		dep_of = { "neo-tree.nvim" },
		event = "DeferredUIEnter",
		after = function()
			require("window-picker").setup({
				highlights = {
					enabled = false,
					statusline = {
						focused = {
							bg = "",
							bold = true,
						},
						unfocused = {
							bg = "",
							bold = true,
						},
					},
				},
			})
		end,
	},
}
