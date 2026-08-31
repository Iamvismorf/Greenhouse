return {
	cmd = { "nixd", "--inlay-hints" },
	filetypes = { "nix" },
	root_markers = { "flake.nix", ".git", "npins", "shell.nix" },
	settings = {
		nixd = {
			formatting = {
				command = { "alejandra" },
			},
		},
	},
}
