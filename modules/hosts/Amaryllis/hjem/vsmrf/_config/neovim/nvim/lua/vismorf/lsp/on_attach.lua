return function(client, bufnr)
	-- local opts = { buffer = bufnr, silent = true }
	local map = function(keys, func, desc)
		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc, silent = true })
	end

	-- vim.lsp.inlay_hint.enable(true)

	local fzf = require("fzf-lua")

	map("<leader>re", fzf.lsp_references, "show definition, references")
	-- map("<leader>De", vim.lsp.buf.declaration, "go to declaration")

	map("<leader>de", fzf.lsp_definitions, "show lsp definitions")

	map("<leader>i", fzf.lsp_implementations, "show lsp implementations")
	map("<leader>t", fzf.lsp_typedefs, "show lsp type definitions")
	map("<leader>rn", vim.lsp.buf.rename, "smart rename")

	map("<leader>di", fzf.diagnostics_document, "show  diagnostics for file") -- pass 0 as bufnr
	-- map("<leader>di", vim.diagnostic.open_float, "show diagnostics for line")

	-- map("<leader>b", vim.lsp.buf.hover)
	map("<leader>ca", vim.lsp.buf.code_action)
end
