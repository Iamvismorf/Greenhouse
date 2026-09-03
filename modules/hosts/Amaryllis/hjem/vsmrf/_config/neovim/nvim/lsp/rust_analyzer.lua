return {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_markers = { ".git", "Cargo.lock", "shell.nix" },
	settings = {
		["rust-analyzer"] = {
			check = {
				command = "clippy",
				allFeatures = true,
			},
			diagnostics = {
				enable = true,
				styleLints = { enable = true },
			},
		},
	},
}
