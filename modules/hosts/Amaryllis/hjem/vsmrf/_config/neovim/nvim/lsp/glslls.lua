return {
	cmd = { "glslls", "--stdin" },
	filetypes = { "glsl" },
	root_markers = { ".git", "shell.nix" },
	capabilities = {
		textDocument = {
			completion = {
				editsNearCursor = true,
			},
		},
		offsetEncoding = { "utf-8", "utf-16" },
	},
}
