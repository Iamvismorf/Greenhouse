--todo: doesn't work
return {
	"crates.nvim",
	ft = "Cargo.toml",
	after = function()
		require("crates").setup({})
	end,
}
