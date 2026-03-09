return {
	"gitsigns.nvim",
	after = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "|" },
				change = { text = "|" },
			},
			signs_staged = {
				add = { text = "|" },
				change = { text = "|" },
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns
				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				map("n", "<leader>h", gs.preview_hunk)
			end,
		})
	end,
}
