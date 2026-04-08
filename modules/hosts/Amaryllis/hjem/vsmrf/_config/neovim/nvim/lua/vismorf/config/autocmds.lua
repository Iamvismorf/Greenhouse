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

--usefull flags:
-- I - don't ignore case
-- g - global
-- c - confirm
