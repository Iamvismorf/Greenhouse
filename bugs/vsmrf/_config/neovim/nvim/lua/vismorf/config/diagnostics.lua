vim.diagnostic.config({
	-- don't change this otherwise the command bellow might break
	virtual_text = false,
	-- virtual_lines = false,
	underline = false,
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = "󰌵 ",
			[vim.diagnostic.severity.INFO] = " ",
		},
		-- linehl = {
		-- 	[vim.diagnostic.severity.ERROR] = "ErrorMsg",
		-- 	[vim.diagnostic.severity.WARN] = "WarningMsg",
		-- 	[vim.diagnostic.severity.HINT] = "DiagnosticHint",
		-- 	[vim.diagnostic.severity.INFO] = "DiagnosticInfo",
		-- },
		numhl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
			[vim.diagnostic.severity.WARN] = "WarningMsg",
			[vim.diagnostic.severity.HINT] = "DiagnosticHint",
			[vim.diagnostic.severity.INFO] = "DiagnosticInfo",
		},
	},
})
vim.api.nvim_create_user_command("FlipVirtualText", function(_)
	if
		vim.diagnostic.config().virtual_text --[[ and vim.diagnostic.config().underline  ]]
	then
		vim.diagnostic.config({
			-- virtual_lines = false,
			virtual_text = false,
			-- underline = false,
		})
	else
		vim.diagnostic.config({
			-- virtual_text = { source = "if_many" },
			virtual_text = true,
			-- virtual_lines = true,
			-- underline = true,
		})
	end
end, { desc = "Toggle virtual text diagnostics" })
