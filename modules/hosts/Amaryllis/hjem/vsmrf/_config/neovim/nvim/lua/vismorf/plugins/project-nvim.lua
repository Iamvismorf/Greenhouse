return {
	"project.nvim",
	after = function()
		require("project_nvim").setup({
			detection_method = { "pattern" },
			patterns = { ".envrc", "flakes.nix", "shell.nix", ".gitignore" },
		})
	end,
}
