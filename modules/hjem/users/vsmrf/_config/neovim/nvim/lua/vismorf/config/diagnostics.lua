vim.diagnostic.config({
	-- don't change this otherwise the command bellow might break
	virtual_text = false,
	-- virtual_lines = false,
	underline = false,
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰧞",
			[vim.diagnostic.severity.WARN] = "󰧞",
			[vim.diagnostic.severity.HINT] = "󰧞",
			[vim.diagnostic.severity.INFO] = "󰧞",
		},
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
			[vim.diagnostic.severity.HINT] = "DiagnosticHint",
			[vim.diagnostic.severity.INFO] = "DiagnosticInfo",
		},
	},
})
