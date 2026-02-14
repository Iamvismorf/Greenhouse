return {
	"project.nvim",
	after = function()
		require("project_nvim").setup({
			detection_method = { "pattern" },
			patterns = { ".git", ".envrc", "flakes.nix", "npins" },
		})
	end,
}
