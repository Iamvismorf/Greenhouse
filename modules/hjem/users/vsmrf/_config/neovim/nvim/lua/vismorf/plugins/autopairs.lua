return {
	"nvim-autopairs",
	event = "InsertEnter",
	after = function()
		require("nvim-autopairs").setup({
			disable_filetype = { "TelescopePrompt", "snacks_picker_input" },
		})
	end,
}
