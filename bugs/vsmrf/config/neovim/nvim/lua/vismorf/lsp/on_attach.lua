return function(ev)
	-- local opts = { buffer = ev.buf, silent = true }
	local map = function(keys, func, desc)
		vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = desc, silent = true })
	end

	local fzf = require("fzf-lua")

	map("<leader>re", fzf.lsp_references, "show definition, references")
	-- map("<leader>De", vim.lsp.buf.declaration, "go to declaration")

	map("<leader>de", fzf.lsp_definitions, "show lsp definitions")

	map("<leader>i", fzf.lsp_implementations, "show lsp implementations")
	map("<leader>t", fzf.lsp_typedefs, "show lsp type definitions")
	map("<leader>rn", vim.lsp.buf.rename, "smart rename")

	-- map("<leader>Di", fzf.diagnostics_document, "show  diagnostics for file") -- pass 0 as bufnr
	map("<leader>di", vim.diagnostic.open_float, "show diagnostics for line")

	-- vim.keymap.set({ "n", "v" }, "<leader>ac", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection
	map("T", vim.lsp.buf.hover, "show documentation for what is under cursor")
end
