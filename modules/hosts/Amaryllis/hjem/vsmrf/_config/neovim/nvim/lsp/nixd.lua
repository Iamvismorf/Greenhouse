return {
	cmd = { "nixd" },
	filetypes = { "nix" },
	settings = {
		nixd = {
			nixpkgs = {
				expr = "import <nixpkgs> { }",
			},
			formatting = {
				command = { "alejandra" },
			},
			options = {
				nixos = {
					expr = "(import ~/Greenhouse/default.nix).nC.Amaryllis.options",
				},
			},
		},
	},
}
