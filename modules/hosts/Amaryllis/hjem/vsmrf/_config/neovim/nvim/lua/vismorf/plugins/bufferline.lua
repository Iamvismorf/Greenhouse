vim.o.showtabline = 2

return {
	"nvim-cokeline",
	event = "DeferredUIEnter",

	--todo: add shift-t like in browser???
	keys = {
		{
			"<S-k>",
			mode = "n",
			function()
				require("cokeline.mappings").by_step("focus", 1)
			end,
		},
		{
			"<S-j>",
			mode = "n",
			function()
				require("cokeline.mappings").by_step("focus", -1)
			end,
		},
		{
			">",
			mode = "n",
			function()
				require("cokeline.mappings").by_step("switch", 1)
			end,
		},
		{
			"<",
			mode = "n",
			function()
				require("cokeline.mappings").by_step("switch", -1)
			end,
		},
	},

	after = function()
		local colors = require("zen.colors").get()
		local theme = colors.theme
		local palette = colors.palette
		require("cokeline").setup({
			default_hl = {
				bg = function(b)
					if b.is_focused then
						return palette.bg3
					end
				end,
			},
			buffers = {
				focus_on_delete = "prev",
				new_buffers_position = "next",
				delete_on_right_click = false,
			},
			components = {
				{
					text = "  ",
				},
				{
					text = function(b)
						return b.devicon.icon
					end,
					fg = function(b)
						return b.devicon.color
					end,
				},
				{
					text = function(b)
						return b.unique_prefix .. b.filename
					end,
					fg = function(b)
						if b.is_focused then
							return palette.rose
						end
					end,
					truncation = {
						direction = "left",
					},
				},
				{
					text = function(b)
						if b.is_modified then
							return " ●"
						else
							return "  "
						end
					end,
					fg = theme.vcs.changed,
				},
				{
					text = " ",
				},
			},
		})
	end,
}
