-- formatter
-- require("lze").load({
return {
	"conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	after = function()
		require("conform").setup({

			formatters_by_ft = {
				lua = { "stylua" },
				nix = { "alejandra" },
				sh = { "shfmt" },
			},

			format_on_save = {
				async = false,
				timeout_ms = 500,
				lsp_fallback = true,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>=", function()
			require("conform").format({
				async = false,
				timeout_ms = 500,
				lsp_fallback = true,
			})
		end)
	end,
}
-- })
