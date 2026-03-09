return {
	"statuscol.nvim",
	after = function()
		local builtin = require("statuscol.builtin")
		require("statuscol").setup({
			segments = {
				{
					sign = { namespace = { "diagnostic" }, maxwidth = 1, colwidth = 2 },
				},
				{ text = { builtin.lnumfunc, " " } },
				{
					sign = { namespace = { "gitsigns" }, maxwidth = 1, colwidth = 2 },
				},
			},
		})
	end,
}
