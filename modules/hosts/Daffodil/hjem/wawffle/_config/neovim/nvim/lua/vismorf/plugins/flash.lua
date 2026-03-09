return {
	"flash.nvim",
	on_require = { "flash" },
	event = "DeferredUIEnter",

	keys = {
		{
			"<leader>s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
		{
			"<leader>S",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash Treesitter",
		},
		-- {
		-- 	"r",
		-- 	mode = "o",
		-- 	function()
		-- 		require("flash").remote()
		-- 	end,
		-- 	desc = "Remote Flash",
		-- },
		-- {
		-- 	"R",
		-- 	mode = { "o", "x" },
		-- 	function()
		-- 		require("flash").treesitter_search()
		-- 	end,
		-- 	desc = "Treesitter Search",
		-- },
		-- {
		-- 	"<c-a>",
		-- 	mode = { "c" },
		-- 	function()
		-- 		require("flash").toggle()
		-- 	end,
		-- 	desc = "Toggle Flash Search",
		-- },
	},
	after = function()
		require("flash").setup({
			modes = {
				search = {
					enabled = false,
				},
			},
		})
	end,
}
