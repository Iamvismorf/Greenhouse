require("vismorf.plugins.rootf").setup({
	rootmarkers = { ".envrc", "flake.nix", "shell.nix", ".gitignore" },
	ignoreDirs = { "%.git*", ".direnv", "build" },
})

require("lze").load({
	{ import = "vismorf.plugins.animate" },
	{ import = "vismorf.plugins.theme" },
	{ import = "vismorf.plugins.gitsigns" },
	{ import = "vismorf.plugins.autopairs" },
	{ import = "vismorf.plugins.bufferline" },
	{ import = "vismorf.plugins.bufjump" },
	{ import = "vismorf.plugins.context" },
	{ import = "vismorf.plugins.statuscol" },
	{ import = "vismorf.plugins.flash" },
	{ import = "vismorf.plugins.fzf-lua" },
	{ import = "vismorf.plugins.indent-blankline" },
	{ import = "vismorf.plugins.snacks" },
	{ import = "vismorf.plugins.surround" },
	{ import = "vismorf.plugins.treesitter" },
	{ import = "vismorf.plugins.ufo" },
	{ import = "vismorf.plugins.yazi" },
})
